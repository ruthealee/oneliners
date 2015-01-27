#!/bin/bash
r='\033[31m'
w='\033[0m'
g='\033[32m'

#####################

This is a basic script to batch add a user to a group across multiple servers. It is non destructive as it uses the -a flag for usermod. This will check the user exists, and the group exists before making changes.

#####################

## A basic usage check to make sure you're providing the right arguments
if [ ! $# == 2 ]; then
  echo "Usage: [username][group]"
  exit
fi

## Beginning our checks with the user

getent passwd $1 > /dev/null

if [[ $? -eq 0 ]]; then
        echo -e "$g[USER EXISTS]$w";

### now we are testing for the group:
	getent group $2 > /dev/null
        if [[ $? -eq 0 ]]; then

## if the group also exists we will add the user:               
                echo -e "$g[GROUP EXISTS]$w";
                usermod -aG $2 $1;
		if [[ $? -eq 0 ]]; then
                	echo -e "$g[ADDED TO GROUP] \\n${w}Group Memberships: \\n$( grep $1 /etc/group | awk -F ':' '{print $1}' | grep -v $1);"
		else
			echo "$rAdding user to group failed$w"
			exit 1
		fi
## if the group does not exist we will report that and exit
        else
                echo -e "$r[GROUP DOES NOT EXIST]$w";
                exit1
        fi;
else
## The user does not exist    
        echo -e "$r[USER DOES NOT EXIST]$w";
        exit 1
fi; 
~         
