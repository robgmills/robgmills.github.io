#!/usr/bin/env bash
docker run \
    --name blog \
    --rm \
    -t \
    -i \
    -v "$PWD":/usr/src/app \
    -p "4000:4000" \
    starefossen/github-pages
