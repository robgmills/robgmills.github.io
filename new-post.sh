#!/bin/sh

LAYOUT="post"
POST_DIR="_posts"
FILE_EXT=".md"
DIR_SEPARATOR="/"

args=("$@")

now=$(date +"%Y-%m-%d")

####
## Collect Input
if [ ${#args[@]} -eq 0 ]; then
  echo "Date [$now]: \c"
  read post_date
  echo "Title: \c"
  read title
  echo "Category (optional): \c"
  read category
  echo "Enter a related permalink (optional): \c"
  read link
fi

if [ -z "${post_date// }" ]; then
  post_date=$now
fi

if [ -z "${title// }" ]; then
  echo "Missing required post title!"
  exit 101
fi
####

####
## Format & build jekyll markdown post file
escaped_url=${title// /-}
low_esc_url="$(echo $escaped_url | tr '[A-Z]' '[a-z]')"

file_meta="---\nlayout: $LAYOUT\n"
file_meta=$file_meta"title: \"$title\"\n"
file_meta=$file_meta"date: $post_date\n"
if [[ -n "${category// }" ]]; then
  file_meta=$file_meta"categories: $category\n"
fi
if [[ -n "${link// }" ]]; then
  file_meta=$file_meta"link: $link\n"
fi
file_meta=$file_meta"---\n"

file="$POST_DIR$DIR_SEPARATOR$post_date-$low_esc_url$FILE_EXT"

echo ${file_meta} > ${file}
####

####
## Do git stuff
git checkout master && \
    git fetch --all && \
    git pull && \
    git checkout -b post/${low_esc_url} && \
    git add ${file} && \
    git commit -m "Initial post ${title}" && \
    git push origin post/${low_esc_url}
####
