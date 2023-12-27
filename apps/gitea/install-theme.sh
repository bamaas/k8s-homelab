#!/bin/bash
# exec into gitea shell
cd /data/gitea
mkdir -p ./public/css
git clone https://github.com/acoolstraw/earl-grey
cp earl-grey/theme-earl-grey.css ./public/css/
rm -r earl-grey