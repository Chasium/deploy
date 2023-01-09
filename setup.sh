#!/bin/sh
rm -rf ./frontend
rm -rf ./fake_frontend
rm -rf ./apigen
rm -rf ./backend
mkdir frontend
mkdir fake_frontend
mkdir apigen
mkdir backend
git clone https://github.com/Chasium/frontend.git ./frontend
git clone https://github.com/Chasium/frontend.git ./fake_frontend
git clone https://github.com/Chasium/backend.git ./backend
git clone https://github.com/Chasium/apigen.git ./apigen
cd apigen
npm install
npm run build
node ./dist/main.js --api ./apis --mustache ./mustache --ts ../frontend/src/apigen --py ../backend/apigen --production
node ./dist/main.js --api ./apis --mustache ./mustache --ts ../fake_frontend/src/apigen --py ../backend/apigen --production
cd ../frontend
npm install
npm run build
cd ../fake_frontend
npm install
rm ./*.json
mv ./src/fake_frontend/_tsconfig.json ./tsconfig.json
rm -rf ./src/router
rm -rf ./src/stores
rm -f ./src/main.ts
npm run tsbuild
cd ..
cp ./docker/Dockerfile_backend ./backend/Dockerfile
cp ./docker/Dockerfile_ff ./fake_frontend/Dockerfile