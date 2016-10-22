# Deploy in appveyor environment

appveyor DownloadFile https://curl.haxx.se/ca/cacert.pem
export SSL_CERT_FILE=cacert.pem
export PATH="C:\\Ruby23\\bin:$PATH"
export CMDSHELL="cmd /C "

$CMDSHELL gem install dpl
$CMDSHELL dpl --provider=bintray --user=$BINTRAY_USER --key=$BINTRAY_API_KEY --file=.bintray.json