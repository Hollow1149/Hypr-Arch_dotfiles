#!/bin/bash

title=$(mpc current -f "%title%")
artist=$(mpc current -f "%artist%")

status=$(mpc status | awk 'NR==2 {print $1}')

if [ "${#status}" -eq 0 ]; then
  icon=""
elif [ "$status" == "[playing]" ]; then
  icon="[Playing]"
elif [ "$status" == "[paused]" ]; then
  icon="[Paused]"
else
  icon=""
fi

case "$1" in
--title)
  if [ ${#title} -gt 22 ]; then
    echo "${title:0:20}.."
  else
    echo "$title"
  fi
  ;;
--artist)
  echo "$artist"
  ;;
--status)
  echo "$icon"
  ;;
esac
