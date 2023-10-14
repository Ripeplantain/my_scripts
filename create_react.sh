#!/usr/bin/bash




        # Author:- Emmanuel Gyang
        # Created:- October 14 2023
        # Updated:- October 14 2023
        # Usage:- create_react.sh

echo "Add typescript y or n"
read message

if [ "$message" == "y" ]; then
    npm init vite@latest ./ -- --template react-ts
else
    npm init vite@latest ./ -- --template react
fi


