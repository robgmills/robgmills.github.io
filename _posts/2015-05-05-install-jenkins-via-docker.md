---
layout: post
title:  "Install Jenkins via Docker"
date:   2015-05-05
categories: tech development howto
---

You should have Docker properly installed on your machine. Check ﻿Docker installation guide for details.

First, pull the official Jenkins Docker image from Docker repository.

    docker pull jenkins

Next, run a container using this image and map data directory from the container to the host; e.g in the example below 
/var/jenkins_home from the container is mapped to jenkins/ directory from the current path on the host. Jenkins 8080 
port is also exposed to the host as 49001.  Remember that if you're using boot2docker on OSX, port 8080 of the Docker 
container is exposed as port 49001 of the boot2docker host VM.  That means you'll need the IP of the host VM.


    docker run -p 49001:8080 -v ${PWD}/jenkins:/var/jenkins_home jenkins

Additionally, you can configure nginx as a reverse proxy to your Jenkins instance, e.g.

    upstream app {
        server 127.0.0.1:49001;
    }
    
    server {
        listen 80;
        server_name jenkins.your-domain.com;
        location / {
            proxy_pass http://app;
        }
    }
