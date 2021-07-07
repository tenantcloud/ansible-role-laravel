#!/usr/bin/env bash

# Added path to 'tcctl' in PATH variable
cd "$(dirname "$0")"/../../ || exit
PATH="$(pwd)/cli:$PATH"
export PATH

if [[ -z "$(command -v bcl)" ]]; then
  echo "We can't find BCL"
  exit 1
fi

echo "Install/Update bcl package from bcl.json"
bcl package install

if [[ -z "$(command -v tcctl)" ]]; then
  echo "We can't find tcctl"
  exit 1
fi

tcctl message --text "Get HOST variables"
HOST=$(tcctl helpers env get --key "HOST")

tcctl message --text "Get nginx vhost file name"
NGINX_VHOST_FILE_NAME=$(ls docker/proxy/conf.d/)

tcctl message --text "We will be using local nginx as a proxy to make HTTPS requests"

tcctl message --text "Create nginx ssl directory if doesn't exist"
mkdir -p /etc/nginx/ssl

tcctl message --text "Copy ssl certificates for $HOST domain"
cp -r docs/installation/ssl/*.tc.loc.* /etc/nginx/ssl

tcctl message --text "Copy nginx virtual host config file"
cp -r docker/proxy/conf.d/*.conf /etc/nginx/sites-enabled

tcctl message --text "Set $HOST value to nginx vhost"
tcctl helpers replace_string_with_escapes \
  --find-string "ssl_certificate /usr/local/etc/nginx/ssl/$HOST.crt;" \
  --replace-string "ssl_certificate /etc/nginx/ssl/$HOST.crt;" \
  --file-name "/etc/nginx/sites-enabled/$NGINX_VHOST_FILE_NAME"

tcctl helpers replace_string_with_escapes \
  --find-string "ssl_certificate_key /usr/local/etc/nginx/ssl/$HOST.key;" \
  --replace-string "ssl_certificate_key /etc/nginx/ssl/$HOST.key;" \
  --file-name "/etc/nginx/sites-enabled/$NGINX_VHOST_FILE_NAME"

tcctl helpers replace_string_with_escapes \
  --find-string "access_log /usr/local/var/log/nginx/$HOST-access.log;" \
  --replace-string "access_log /var/log/nginx/$HOST-access.log;" \
  --file-name "/etc/nginx/sites-enabled/$NGINX_VHOST_FILE_NAME"

tcctl helpers replace_string_with_escapes \
  --find-string "error_log  /usr/local/var/log/nginx/$HOST-error.log error;" \
  --replace-string "error_log  /var/log/nginx/$HOST-error.log error;" \
  --file-name "/etc/nginx/sites-enabled/$NGINX_VHOST_FILE_NAME"

tcctl message --text "Add $HOST domains in /etc/hosts"
tcctl helpers insert_string \
  --insert-string "127.0.0.1 $HOST minio.$HOST mail.$HOST \
supervisor.$HOST selenoid.$HOST" \
  --file-name "/etc/hosts"

tcctl message --text "Restart local nginx server"
sudo service nginx restart

tcctl message --text "That's all!"
tcctl message --text "Have a nice day!"
