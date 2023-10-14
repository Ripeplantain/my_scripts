#!/usr/bin/bash




	# Author:- Emmanuel Gyang
	# Created:- September 2022
	# Updated:- April 19 2023
	# Usage:- autopush.sh <branch>




branch=$1
echo "Enter commit message"
read message

git add .
git commit -m "$message"

if [ "$branch" == "main" ]; then
    git push
else
    git push origin "$branch"
fi

echo "Your code has been pushed successfully"

