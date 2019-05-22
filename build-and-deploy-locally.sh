#set -e # bash fail if any fails
. build.sh
target=~/prototypes/external/multiversum
rm -rf $target
mv _site $target
