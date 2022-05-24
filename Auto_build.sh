#!/bin/sh
LOG=/home/ec2-user/autobuild.log
##ECR Login##
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com
###VAR##
COUNT_IMAGE=$(docker images|wc -l)
###Faction###
CLEAR()
{
docker rmi $(docker images -a -q) --force
}
CLEAR_DOCKER()
{
docker stop $(docker ps |grep wordpress|awk '{print $5}')
}
BUILD()
{
if[ $COUNT_IMAGE -eq 0 ]
then 
    docker build -t Wordpress:$1 .
else
    echo "Please clear docker image"
}

TAG()
{
docker tag Wordpress:$1 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com/pralop-repo:$1
}

PUSH()
{
docker push 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com/pralop-repo:$1
}

PULL()
{
docker pull 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com/pralop-repo:$1
}

DOCKER_RUN()
{
docker run -d -p 80:80 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com/pralop-repo:$1
}

###Main###
if[ $COUNT_IMAGE != 0 ]
then
  CLEAR
else
  BUILD
  TAG
  PUSH
  DOCKER_RUN
