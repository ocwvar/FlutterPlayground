# get all args from outside first
pwd=$1
aliasName=$2
signFileName=$3
encodedSignFileString=$4

# write them into key.properties
echo "Writing secrets into properties file"
echo "password=$pwd" > key.properties
echo "aliasName=$aliasName" >> key.properties
echo "signFilePath=../$signFileName" >> key.properties

echo "Decoding SignFile Base64 and output to local"
echo "$encodedSignFileString" > key.temp
base64 --decode key.temp > "$signFileName"
ls -l
rm -rf key.temp

echo "Begin to build release APK"
flutter build apk

echo "Delete sign file and properties file"
rm -rf "$signFileName"
rm -rf key.properties
