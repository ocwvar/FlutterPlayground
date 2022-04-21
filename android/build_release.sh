# switch to work folder
cd android/

# all those env params are set in dart.yml
echo "Writing secrets to file"
echo password=$PWD >> key.properties
echo aliasName=$ALIAS >> key.properties
echo signFilePath=../$SIGN_FILE_NAME >> key.properties
echo $ENCODED_SIGN_FILE >> key.temp

echo "Decoding SignFile Base64 and output to local"
base64 --decode key.temp > sign.key
ls -l ./

# go back to root folder
cd ..