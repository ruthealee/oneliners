#!/bin/sh
## This is a simple script to output the status of user accounts on a server

(while IFS=: read user pass uid gid full home shell; do
  if [[ $shell == /sbin/nologin ]] || [[ $shell == /sbin/false ]]; then
    echo "$user : no-shell/system-user"
  else
    if [[ $(grep $user /etc/shadow | awk -F ":" '{print substr ($2, 0,1)}') == "!" ]]; then
      echo "$user : inactive"
    else 
      echo "$user : active"
    fi
  fi
done < /etc/passwd) | sort -k 3 | column -t


