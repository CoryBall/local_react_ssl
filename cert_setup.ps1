#Requires -RunAsAdministrator

$localCertsPath = ".\local_certs"
$localCertsExtensionPath = ".\local_certs\openssl.conf"
$localCertsExtensionContents = @"
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
CN = localhost

[v3_req]
subjectAltName = @alt_names
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment

[alt_names]
DNS.1 = localhost
"@

New-Item -ItemType Directory -Path $localCertsPath
New-Item -ItemType File -Path $localCertsExtensionPath
$localCertsExtensionContents | Out-File -FilePath $localCertsExtensionPath -Encoding UTF8

openssl req -x509 -newkey rsa:2048 -sha256 -nodes -days 365 -keyout local_certs/private.key -out local_certs/certificate.crt -config local_certs/openssl.conf

import-certificate -filepath local_certs\certificate.crt -certstorelocation Cert:\LocalMachine\Root