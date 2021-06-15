#!/bin/bash


echo "Enter Container Name"
read contName

run=1

if !  sudo docker run -d -p 80:80 --name $contName nginx ; then
	echo "Unable to run Docker"
	run=0
fi

if ! sudo docker cp docker-share/html/index.html $contName:/usr/share/nginx/html ; then
	if (($run==0)); then
		echo "Container doesnot exist"
	fi
fi


echo "Enter Repository Name"
read repoName

echo "Enter Container Tag"
read tag

echo "Enter User Name"
read userName

echo "Enter Password"
read pass

curl localhost

imageName=$userName
imageName+="/"
imageName+="$repoName"
imageName+=":"
imageName+="$tag"

if ! sudo docker commit $contName $imageName ; then
	if (($run==0)); then
		echo "Container $sontName Does not exist, Cannot Commit"
	else
		echo "Cannot Commit"
	fi
fi

if !  sudo docker login --username $userName --password $pass 2>/dev/null ; then
	echo "unable to login"
fi

sudo docker push $imageName

