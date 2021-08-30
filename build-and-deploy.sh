#set -e # bash fail if any fails
. build.sh
target=../danse.github.io
rm -rf $target/*
mv _site/* $target
cabal v1-run site clean
cd $target
git add -A
git commit -m update
git push
cd -
