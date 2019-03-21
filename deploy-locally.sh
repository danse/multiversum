# bash fail if any fails
target=~/prototypes/external/multiversum
stack run site clean
stack run site build
rm -rf $target
mv _site $target
