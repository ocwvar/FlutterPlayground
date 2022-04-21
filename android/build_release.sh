echo "Decoding SignFile Base64 and output to local"
base64 --decode ./key.temp > ./sign.key
ls -l ./