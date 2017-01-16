rm -rf ../danse.github.io/*
mv _site/* ../danse.github.io
cabal run site clean
cd ../danse.github.io
git add -A
git commit -m update
git push
