#!/usr/bin/env bash
kubectl help 
if [[ $? == 0 ]];
then
	echo "kubectl exists"
else 

	curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
	sudo chmod 755 kubectl
	sudo mv kubectl /usr/bin/kubectl
fi
