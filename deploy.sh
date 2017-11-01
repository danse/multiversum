mkdir -p posts
rm posts/*
cp -n ~/rotterdam/posts/* posts
cabal run site clean && cabal run site build
rm -rf ../danse.github.io/*
mv _site/* ../danse.github.io
cabal run site clean
cd ../danse.github.io
git add -A
git commit -m update
git push
cd -
