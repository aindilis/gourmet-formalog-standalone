#!/bin/sh

docker build --rm  .
# docker run -e "USER=andrewdo" -e "GROUP=andrewdo" -e "USER_ID=1000" -e "GROUP_ID=1000" .

# docker run --rm -v "$(pwd):/$pwd | slugify)" -w "/$(pwd | slugify)" -ti --entrypoint=aindilis-gourmet-formalog-standalone

# docker run --rm -ti --entrypoint= aindilis-gourmet-formalog-standalone-2146d58a:1.0 bash
