# ############ #
# AUTH SERVICE #
# ############ #

# create python virtual environment
python3 -m venv venv

# activate virtual env
source ./venv/bin/activate
env | grep VIRTUAL # just to check

# create database and gateway api user
mysql -uroot < init.sql

# create python's requirements.txt
pip3 freeze > requirements.txt

# tag and push the docker image
cd python/src/auth
docker build . -t guilpejon/auth:latest
# docker tag <aa102310539f6e8f343a6e3074cf7df6abc1a> guilpejon/auth:latest
docker push guilpejon/auth:latest

minikube start
k9s # check the started pods

# start service, secret, configmap and deployment
cd python/src/auth/manifests
kubectl apply -f ./
