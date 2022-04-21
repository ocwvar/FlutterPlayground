# switch to work folder
cd android/

# all those env params are set in dart.yml
echo "Writing secrets to file"

# write sign config to android/key.properties
echo pd=$PASS >> key.properties
echo aliasName=$ALIAS >> key.properties
echo signFilePath=../$SIGN_FILE_NAME >> key.properties

echo "Decoding SignFile Base64 and output to local"
# write encoded base64 text to android/key.temp for decode later
echo $ENCODED_SIGN_FILE >> key.temp

# begin decode base64 text and output to $SIGN_FILE_NAME
base64 --decode key.temp > $SIGN_FILE_NAME

# go back to root folder
cd ..

# begin to build
echo "Begin to build release APK"
flutter build apk

echo "Begin to build release AppBundle"
flutter build appbundle