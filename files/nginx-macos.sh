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

tcctl message --text "We will be using local nginx as a proxy to make HTTPS requests"

tcctl message --text "Set Nginx worker_processes to auto"
tcctl helpers replace_string \
  --find-string "^worker_processes  1;" \
  --replace-string "worker_processes  auto;" \
  --file-name "/usr/local/etc/nginx/nginx.conf"

tcctl message --text "Set nginx worker_rlimit_nofile to 20000"
tcctl helpers append_string_after \
  --find-string "worker_processes  auto;" \
  --append-string "worker_rlimit_nofile    20000;" \
  --file-name "/usr/local/etc/nginx/nginx.conf"

tcctl message --text "Set client_max_body_size to 512M"
tcctl helpers append_string_after \
  --find-string "http {" \
  --append-string "\    client_max_body_size 512M;" \
  --file-name "/usr/local/etc/nginx/nginx.conf"

tcctl message --text "Create nginx ssl directory if doesn't exist"
mkdir -p /usr/local/etc/nginx/ssl

tcctl message --text "Create nginx servers directory if doesn't exist"
mkdir -p /usr/local/etc/nginx/servers

tcctl message --text "Copy ssl certificates for $HOST domain"
cp -r docs/installation/ssl/*.tc.loc.* /usr/local/etc/nginx/ssl

tcctl message --text "Copy nginx virtual host config file"
cp -r docker/proxy/conf.d/*.conf /usr/local/etc/nginx/servers

tcctl message --text "Add $HOST domains in /etc/hosts"
tcctl helpers insert_string \
  --insert-string "127.0.0.1 $HOST minio.$HOST mail.$HOST \
supervisor.$HOST selenoid.$HOST" \
  --file-name "/etc/hosts"

tcctl message --text "Trust root certificate in the system"
tcctl dns cert_trust --root-cert-path "docs/installation/ssl/tenantcloud-rootCA.crt"

tcctl message --text "Restart local nginx server"
sudo brew services restart nginx

tcctl message --text "That's all!"
tcctl message --text "Have a nice day!"
