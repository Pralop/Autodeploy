#!/bin/sh
LOG=/home/ec2-user/autobuild.log
rm -f $LOG
##ECR Login##
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com
###VAR##
TAG_NO=$(echo $1)
COUNT_IMAGE=$(docker images|wc -l)
###Faction###
CLEAR()
{
CHECK_IM=$(docker images -a |grep -i wordpress|awk '{print $3}'|wc -l)
if [ $CHECK_IM -eq 1 ]
then
        docker rmi $(docker images -a -q) --force|tee -a $LOG
else
        echo "Can't clear"
fi
}

CLEAR_DOCKER()
{
docker stop $(docker ps |grep amazon|awk '{print $12}')
}
BUILD()
{
        docker build -t $TAG_NO .
}

TAG()
{
docker tag $TAG_NO 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com/pralop-repo:$TAG_NO|tee -a $LOG
}

PUSH()
{
docker push 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com/pralop-repo:$TAG_NO|tee -a $LOG
}

PULL()
{
docker pull 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com/pralop-repo:$TAG_NO|tee -a $LOG
}

DOCKER_RUN()
{
docker run -d -p 80:80 628007638077.dkr.ecr.ap-southeast-1.amazonaws.com/pralop-repo:$TAG_NO|tee -a $LOG
}

###Main###
if [ $COUNT_IMAGE -gt 2 ]
then
  CLEAR_DOCKER
  sleep 10
  CLEAR
  echo "Prepare Build Image"
  sleep 10
  BUILD
  TAG
  PUSH
  DOCKER_RUN
else
  BUILD
  TAG
  PUSH
  DOCKER_RUN
fi
