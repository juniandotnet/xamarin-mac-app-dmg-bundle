#!/bin/bash

PROJECT_NAME=XamMacDemo
APP_NAME=Xamarin\ Mac\ Demo
APP_VERSION=1.0.0

CURRENT_DIR=$PWD

cd $CURRENT_DIR/src/

# restore nuget packages
nuget restore

# build project in Release mode
msbuild ${PROJECT_NAME}.sln \
    /t:"${PROJECT_NAME}:rebuild" \
    /p:Configuration="Release"

cd $CURRENT_DIR/scripts/create-dmg/

mkdir -p $CURRENT_DIR/setup/app

rm -rf $CURRENT_DIR/setup/*.dmg

cp -r \
    "$CURRENT_DIR/src/${PROJECT_NAME}/bin/Release/${APP_NAME}.app" \
    "$CURRENT_DIR/setup/app/"

./create-dmg \
    --volname "$APP_NAME Installer" \
    --background $CURRENT_DIR/dmg-background.png \
    --window-size 660 400 \
    --icon-size 160 \
    --app-drop-link 480 170 \
    --icon "$APP_NAME.app" 180 170 \
    "$CURRENT_DIR/setup/${APP_NAME}-v${APP_VERSION}.dmg" \
    $CURRENT_DIR/setup/app

rm -rf $CURRENT_DIR/setup/app/