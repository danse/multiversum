#set -e # bash fail if any fails
. build.sh
target=/tmp
rm -rf $target/_site
mv _site $target
echo "deployed to $target"
