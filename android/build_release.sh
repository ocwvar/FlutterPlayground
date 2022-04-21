# switch to work folder
cd android/

# all those env params are set in dart.yml
echo "Writing secrets to file"
echo password=$PWD >> android/key.properties
echo aliasName=$ALIAS >> android/key.properties
echo signFilePath=../$SIGN_FILE_NAME >> android/key.properties
echo $ENCODED_SIGN_FILE >> android/key.temp

echo "Decoding SignFile Base64 and output to local"
base64 --decode ./key.temp > ./sign.key
ls -l ./

# go back to root folder
cd ..