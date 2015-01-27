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

if [[ -n "$( getent passwd $1)" ]]; then

        echo -e "$g[USER EXISTS]$w";

### now we are tsting for the group:
        if [[ -n "$( grep ^$2: /etc/group)" ]]; then

## if the group also exists we will add the user:               
                echo -e "$g[GROUP EXISTS]$w";
                usermod -aG $2 $1;
                echo -e "$g[ADDED TO GROUP] \\n${w}Group Memberships: \\n$( grep $1 /etc/group | awk -F ':' '{print $1}' | grep -v $1);"

## if the group does not exist we will report that and exit
        else
                echo -e "$r[GROUP DOES NOT EXIST]$w";
                exit
        fi;
else
## The user does not exist    
        echo -e "$r[USER DOES NOT EXIST]$w";
        exit
fi;
~         
