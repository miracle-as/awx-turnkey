#!/usr/bin/env bash

        	containers=$(kubectl get po  $pod -o json|  tee kubectl.json   |jq -c 'paths' |tr -d '['  | sed  "s/[0-9]./\[&\]/g" |sed "s/\"\,\[/[/g" |tr -d ',' |sed "s/\"\]$//"|tr '"' '.' |sed "s/\.\./\./g"   |sed "s/^/'/" |sed "s/$/'/"  |grep -i ".status.containerStatuses"| grep "name'$" |xargs -i{} jq  {} kubectl.json |tr -d '"' )

pods=$(kubectl get po  |grep -v "NAME" |awk '{ print $1 }')

for pod in $pods
do

       	containers=$(kubectl get po  $pod -o json|  tee /tmp/kubectl.json   |jq -c 'paths' |tr -d '['  | sed  "s/[0-9]./\[&\]/g" |sed "s/\"\,\[/[/g" |tr -d ',' |sed "s/\"\]$//"|tr '"' '.' |sed "s/\.\./\./g"   |sed "s/^/'/" |sed "s/$/'/"  |grep -i ".status.containerStatuses"| grep "name'$" |xargs -i{} jq  {} /tmp/kubectl.json |tr -d '"' )

	for container in $containers
	do
		printf "%-40s %-20s \n" $pod   $container
 		kubectl exec --tty -c $container $pod  -- id
 		kubectl exec --tty -c $container $pod  -- ps -ef
	done
done
