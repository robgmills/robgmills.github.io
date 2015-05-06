---
layout: post
title:  "Install Jenkins via Docker"
date:   2015-05-05
categories: tech development howto
---

You should have Docker properly installed on your machine. Check ﻿Docker installation guide for details.

First, pull zaiste/jenkins image from Docker repository.

````
docker pull zaiste/jenkins
````

Next, run a container using this image and map data directory from the container to the host; e.g in th example below /var/lib/jenkins from the container is mapped to jenkins/ directory from the current path on the host. Jenkins 8080 port is also exposed to the host as 49001.

````
docker run -d -p 49001:8080 -v $PWD/jenkins:/var/lib/jenkins -t zaiste/jenkins
````

Additionally, you can configure nginx as a reverse proxy to your Jenkins instance, e.g.

````
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
````