---
layout: post
title: "Ray Tsang's tips & tricks for Docker"
date: 2017-08-22
categories: development
---

Ray Tsang, Developer Advocate at Google, gave a presentation titled _Docker Tips and Tricks for Java Developers_ to the [Chicago Java User's Group today](https://www.meetup.com/ChicagoJUG/events/238745748/).
Despite having run Docker in production for nearly 2 years, I got a ton out of it.
Ray Tsang is also an avid traveler and photographer and can be reached on [Twitter](https://twitter.com/saturnism), [LinkedIn](https://www.linkedin.com/in/rayjtsang/) and [GitHub](https://github.com/saturnism) (but mostly via Twitter).

_*UPDATE:* The gracious folks from [Spantree](https://www.spantree.net/) [recorded the session on behalf of the CJUG and you can find the video here](https://vimeo.com/239852824)._

# Tips for all Docker containers
## Minimize layers as much as possible
Each layer takes up extra space.  
Combine `RUN` commands into a single line if possible using the _and_ (`&&`) and _pipe_ (`|`) shell operators.
There are some caveats to this detailed in other tips below.

#### Incorrect

    FROM debian:jessie
    RUN apt-get -y update
    RUN apt-get -y install curl openjdk8

#### Correct

    FROM debian:jessie
    RUN apt-get -y update && apt-get -y install curl openjdk8

## Never write to the container filesystem
The filesystem sticks around long after the container has stopped and you can fill up the disk of the host machine.  
Instead, write your logs to stdout and if you need to write application data to disk, mount a volume in the container and write to that.

If you do happen to fill up your disk, use the following command to remove abandoned docker filesystems still on your host:

    docker system prune

And when you're running a docker container, use the `--rm` flag to automatically clean up the container and its filesystem after it stops.

    docker run --rm nginx

It's handy to set up an `alias` in your `.bashrc` file to do this for you:

    alias drrm=docker run --rm

## Never use latest
When extending Docker images in your own custom Dockerfile using the `FROM` directive, if you use the latest tag of that base image, it makes your Docker container build non-deterministic.  
Instead, explicitly pin the version of the base image you're extending to prevent this from happening.  
[Stacksmith by Bitnami](https://stacksmith.bitnami.com) can help you generate version-safe Dockerfiles for all software stacks.

On the other side, always tag your images, preferably with a semantically versioned number AND a short hash of the build

#### Incorrect

    docker build -t uptake/myapp

#### Correct

    docker build -t uptake/myapp:2.0-4fce3 .

## Never run processes as the root user
While Docker is great at resource isolation, you don't do everything as root for a reason.
Set a user to run the process as using the `USER` directive in your Dockerfile.

## Don't chown a directory
When you `COPY` files and directories into a Docker image, the operation is performed as the root user.  
If you need access to those files as a different user (because you set the `USER` directive as described above), you might have some trouble.  
The easy solution is to include a `RUN` directive that changes the permissions or ownership of those files:

    FROM nginx:1.13.2-alpine
    COPY . /usr/share/nginx/html
    RUN chown -R nginx:nginx /usr/share/nginx/html

But in doing this, Docker creates an extra layer that's the size of all of the files in that directory which can result in a container that's double the size of the files within it!!!

## Run a shared or remote Docker daemon
This caches base image layers, custom image layers and other dependencies.

This requires configuring the docker command to target the remote daemon.
[Docker Machine offers a `-d/--driver` flag](https://docs.docker.com/machine/get-started-cloud/) when creating a new docker machine that will automatically set up the Docker host in the cloud provider of your choice:

    docker-machine create -d google 

## Use multistage builds in single Dockerfile to build your application and export results into smaller base image
Doing so caches your build dependencies in the remote docker host, shortening build times further.  
The resulting image is smaller and lighter (especially if you use an alpine linux base image).

    FROM maven as BUILD
    COPY . /src
    RUN mvn -f /src/pom.xml package
    
    FROM openjdk:8u131-alpine
    COPY --from=BUILD lib /opt/lib
    COPY --from=BUILD app.jar /opt/app.jar
    ENTRYPOINT ["java", "-jar", "/opt/app.jar"]

## Compress your Docker images
Use the `--compress` flag to compress the build context payload sent to the Docker daemon to further speed up builds:

    docker build --compress -t uptake/myapp:2.0-4fce3 .

## Docker containers are just processes
You can pipe data to them via `stdin` and read data out of them using `stdout`.

    cat setup.json |  docker run -i ubuntu /bin/bash -c 'jq .' | cat

## Use an orchestrator
Container orchestration frameworks come with a lot of handy features that make running containers at scale easy-peasy-nice-and-easy.
We use [Apache Mesos](https://mesos.apache.org) (via Mesosphere DC/OS) here at [Uptake](https://uptake.com).  Other popular orchestrators are Kubernetes and Docker Swarm.

# Tips for Java Docker containers
## Copy your dependencies in as a separate layer
Doing so caches your dependencies (which rarely changes) resulting in faster build times.  
Do this directly before copying your application code, which changes often and should be the last layer in your Docker image.  

This also means you can...

# Build your application jar without your dependencies
This creates a smaller binary to COPY into the Docker image which results in a smaller layer, which results in a smaller overall Docker container.

# JVM flags
If you run your JVM app in a container, you MUST set:

## Max Heap
Failing to set this when running your application will result in the application claiming all of the available memory as heap space.  
If you app proceeds to then use that available heap space and you've allocated less than than when running the container, Docker may kill your container.  
This could result in your orchestrator unnecessarily shuffling Docker containers across hosts in the cluster!

In your Dockerfile, when defining the `ENTRYPOINT` directive that executes your Java application, make sure to set the `-Xmx` flag:

    FROM maven as BUILD
    COPY . /src
    RUN mvn -f /src/pom.xml package
    
    FROM openjdk:8u131-alpine
    COPY --from=BUILD lib /opt/lib
    COPY --from=BUILD app.jar /opt/app.jar
    ENTRYPOINT ["java", "-Xmx200m", "-jar", "/opt/app.jar"]
    

## ParallelGCThreads
Failing to set this will make the JVM think it can use all of the available virtual CPU cores for garbage collection.
This makes sense if the JVM uses the system and its resources exclusively.
But when there are multiple JVM processes on the same system, you could negatively impact the performance of other containers running on your host by claiming more cores for more threads than you need.
This feels like a weird leaky abstraction of the underlying resources by a tool that prides itself on resource isolation.  
To get around this, use the `-XX:ParallelGCThreads=<value>` flag to prevent your container from being a bad neighbor.

    FROM maven as BUILD
    COPY . /src
    RUN mvn -f /src/pom.xml package
    
    FROM openjdk:8u131-alpine
    COPY --from=BUILD lib /opt/lib
    COPY --from=BUILD app.jar /opt/app.jar
    ENTRYPOINT ["java", "-XX:ParallelGCThreads=2", "-Xmx200m", "-jar", "/opt/app.jar"]


## UseCGroupMemoryLimitForHeap
The JDK 8u131 has a backported feature from JDK 9 that enables the JVM to detect memory availability when running in a Docker container.

    FROM maven as BUILD
    COPY . /src
    RUN mvn -f /src/pom.xml package
    
    FROM openjdk:8u131-alpine
    COPY --from=BUILD lib /opt/lib
    COPY --from=BUILD app.jar /opt/app.jar
    ENTRYPOINT ["java", "-XX:ParallelGCThreads=2", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Xmx200m", "-jar", "/opt/app.jar"]
    -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap

Please note that this is an experimental flag that requires enabling!

[Carlos Sanches goes into deeper detail in a dzone blog post.](https://dzone.com/articles/running-a-jvm-in-a-container-without-getting-kille)
