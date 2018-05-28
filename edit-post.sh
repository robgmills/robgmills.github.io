#!/usr/bin/env bash

shopt -s nullglob
POSTS=(_posts/*.md)
POSTS_LEN="$((${#POSTS[@]} - 1))"

i=0
for post in "${POSTS[@]}"; do
  title=$(awk -F '"' '/^title:/{print $2}' $post)
  printf "%s - %s\n" $i "$title"
  ((i++))
done

read -p "Post to edit [$POSTS_LEN]: " editIndex
editIndex=${editIndex:-$POSTS_LEN}

if [[ $editIndex =~ ^-?[0-9]+$ ]]; then
  printf "Editing %s\n" $editIndex
  eval ${EDITOR:-vim} ${POSTS[$editIndex]}
else
  printf "Must choose valid post!"
  exit 101
fi
