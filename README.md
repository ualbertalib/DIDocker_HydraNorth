How to get started
using HydraNorth docker image with sqlite3 or mysql database

Make sure that you have docker installed and running on you workstation
check that it is running by trying to run hello-world immage

$docker run hello-world

Pull latest image of hydra_north

$docker pull ualibraries/hydra_north_sqlite or
$docker pull ualibraries/hydra_north_mysql

Clone HydraNorth code repository from github

$git clone https://github.com/ualbertalib/HydraNorth.git
go to the directory where you cloned your HydraNorth and edit Gemfile
make sure that following line is in the development section:

gem 'sqlite3'
if you plan to use ualibraries/hydra_north_sqlite image

/*this will not be necessary once I committed my changes to the HydraNorth repository */

Clone DIDockerImages from github

$git clone https://github.com/ualbertalib/DIDockerImages.git


Set some environment variables:

LOCAL_SRC_PATH should point to the directory where you cloned your HydraNorth github repository

$export LOCAL_SRC_PATH='/home/myname/src/HydraNorth'

EZID_PASSWORD should contain ezid testing password

Now you are done, just run shell script from DIDockerImages/HydraNorth runDockerImage_sqlite.sh
or runDockerImage_mysql.sh scripts:

$cd /home/myname/src/DIDockerImages/HydraNorth
$ ./runDockerImage_sqlite.sh
or
$ ./runDockerImage_mysql.sh

Wait for about 30 seconds and point your browser to http://localhost:3000 and you shoud see instancd of HydraNorth running.
You can also see Solr and Fedora running if you point your browser to http://localhost:8983

In order to deposit an item, you must first create a community via the dashboard.

You can access Fedora at http://localhost:8983/fedora , and solr at http://localhost:8983/solr . The Resque gui 
is at http://localhost:3000/admin/queues/overview




To stop running docker image:

$docker ps

you will see list of all running containers, find HydraNorth container id and issue command

$docker stop <containter_id>

To go inside container and execute command there

$docker exec -it <container_id> /bin/bash
