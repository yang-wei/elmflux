# cleaning up
rm -rf out || exit 0;

# install elm and its dependencis
npm --version
node --version

npm install -g elm
elm package install --yes

# build
mkdir -p build
elm make src/Main.elm --output build/main.js

# create directory
mkdir -p out
cp index.html out
cp -r assets/ out
cp -r build/ out
cd out

# ready to deploy to gh-pages branch
git init
git config user.name "Travis-CI"
git config user.email "travis@yang-wei.com"
git add .
git commit -m "Deploy to GitHub Pages"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1
