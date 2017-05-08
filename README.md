# How to get started using HydraNorth docker image

This is project to get [HydraNorth](https://github.com/ualbertalib/HydraNorth) running in docker environment.
There are two docker files here Dockerfile.hydranorth.centos and Dockerfile.hydranorth.deb. First one is to
build docker image based on centos 6.9 using our local ualib reposotories and second one is to build
hydranorth based on official ruby debian image.
Centos docker image is designed to make environment identical to our produciton version of HydraNorth. It contains
our own compiled version of ffmpeg with all required codecs.
Debian based docker image is derived from official ruby image (debian based) and suitable for those who do not have
access to ualib repositories.

## Prerequisites:

  1. [Install Docker](https://docs.docker.com/engine/installation/)
  2. Clone current project:
     ```shell
     git clone https://github.com/ualbertalib/di_docker_hydranorth.git
     ```
  3. Build your own docker image or download existing one

     * build your own docker image
       (if you choose to skip this step you can always pull pre build
       images from [dockerhub](https://hub.docker.com/), see next step)
       ```shell
       docker build -f Dockerfile.hydra_centos . -t hydra_north:centos
       or
       docker build -f Dockerfile.hydra_deb . -t hydra_north:deb
       ```
     * download docker image from dockerhub
       Pull [image from dockerhub repository](https://hub.docker.com/r/ualibraries/hydra_north/)
       ```shell
       docker pull ualibraries/hydra_north:centos
       or
       docker pull ualibraries/hydra_north:deb
       ```

##  Running HydraNorth

  Clone HydraNorth code repository from github

  ```shell
  $git clone https://github.com/ualbertalib/HydraNorth.git
  ```

  Set some environment variables:

  LOCAL_SRC_PATH should point to the directory where you cloned your HydraNorth github repository

  ```shell
  export LOCAL_SRC_PATH='/home/myname/src/HydraNorth'
  ```

  EZID_PASSWORD should contain ezid testing password.<br />
  IMG_TAG should be set to either 'centos' or 'deb' depending on image you are using.<br />
  Now you are done, just run shell script from di_docker_hydranorth

  ```shell
  $ ./runDockerImage.sh
  ```

  Wait for about 30 seconds and point your browser to [localhost port 3000](http://localhost:3000) and you
  should see instance of HydraNorth running. You can also see Solr and Fedora running if you point your
  browser to  [localhost port 8983](http://localhost:8983)

  In order to deposit an item, you must first create a community via the dashboard.

  The Resque gui can be access  via [this link](http://localhost:3000/admin/queues/overview)




## Useful commands:

 * `docker ps -`                                 to see all running containers
 * `docker logs -f <container_name>`             to see logs from a given container
 * `docker exec -it <container_name> /bin/bash`  to start shell inside running container
 * `docker stop <containter_id>`                 to stop running container

