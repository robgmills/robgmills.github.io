---
layout: post
title:  "Clear Docker of containers and images"
date:   2015-06-17
categories: development
link: http://techoverflow.net/blog/2013/10/22/docker-remove-all-images-and-containers/
---

In order to stop all running Docker containers, delete them, and remove their images, run the following command:

```sh
docker stop $(docker ps -a -q) &&
docker rm $(docker ps -a -q) &&
docker rmi $(docker images -q)
```

*WARNING: This will delete everything and you cannot recover it!* 