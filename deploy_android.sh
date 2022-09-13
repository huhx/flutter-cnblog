#!/usr/bin/env bash
COMMIT_HASH=$(git rev-parse --short HEAD)

# build the apk
echo "------------------------------  start build android apk  ------------------------------"
BUILD_START=$(date +%s)
flutter clean
flutter build apk --obfuscate --split-debug-info=symbols --target-platform=android-arm64 --build-name="$COMMIT_HASH"
BUILD_END=$(date +%s)
BUILD_TIME=$((BUILD_END - BUILD_START))
printf "flutter build took %s seconds.\n" $BUILD_TIME

echo "------------------------------  start upload apk  ------------------------------"
# upload apk to server
UPLOAD_START=$(date +%s)
FILENAME=build/app/outputs/apk/release/app-release.apk
FILE_SIZE=$(stat -f%z "$FILENAME")

curl -F "file=@$FILENAME" \
-F "buildInstallType=3" \
-F "buildPassword=huhx" \
-F "uKey=$pgyer_key" \
-F "updateDescription=flutter-cnblog" \
-F "_api_key=$pgyer_secret" \
https://upload.pgyer.com/apiv1/app/upload

UPLOAD_END=$(date +%s)
UPLOAD_TIME=$((UPLOAD_END - UPLOAD_START))
printf "\n"
printf "upload took %s seconds and size is $FILE_SIZE kb.\n" $UPLOAD_TIME

echo "------------------------------  start update apk  ------------------------------"

echo "download link: https://www.pgyer.com/iwpS"

