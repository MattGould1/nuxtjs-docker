# nuxtjs-docker
NuxtJS + NGINX + Docker

## Setup

### Generate SSL certificates (DEV ONLY)

#### Ubuntu users
``` bash
./generate_cert.sh
```

this script will update apt-get, optionally install openssl (if you do not have it) and then generate your certificates in the certs folder.

#### Everyone else
You may generate your own certificates (or use pre-existing), update your .env file to reflect the filepath of your certificates.

### Docker Build
``` bash
docker-compose build
```

### DOTENV
``` bash
cp .env.example .env
```

``` bash
ENVIRONMENT=dev # Controls which NGINX config file to load
SSL_CERT_PATH=./certs/localhost.crt
SSL_CERT_KEY_PATH=./certs/localhost.key
```

### NGINX Config

### Dev
You must create or use a pre-existing site from your hosts file

``` bash
sudo vi /etc/hosts
```

Now you must change the server_name value in the NGINX config file (./config/dev.conf) for both http (80) and https (443)

e.g. server_name nuxtjs-docker.dev; > server_name your_site.dev;

#### Prod
Open your .env and change the value of ENVIRONMENT

e.g. change "dev" to "prod"

You must now create a new NGINX config file, with a name matching the value of your ENVIRONMENT value.

e.g. ./config/prod.conf

You may copy the contents from ./config/dev.conf

``` bash
cp ./config/dev.conf ./config/prod.conf
```

You must now update the server_name value in your new conf file.

### NPM

Log into your nuxtjs container

``` bash
docker-compose run nuxtjs bash
```

#### Install
You will need to run `npm install` the first time you setup docker, this will create your node_modules directory.

``` bash
npm install
```

#### Installing New Packages

``` bash
npm install package-name --save
```

## Running Nuxt + Docker

### DOTENV
Before running Docker you must make sure that a config file for your ENVIRONMENT exists and that you have included SSL certificates. Below is an example of a production .env using letsencrypt certificates.

```
ENVIRONMENT=prod
SSL_CERT_PATH=/etc/letsencrypt/live/example.com/cert.pem
SSL_CERT_KEY_PATH=/etc/letsencrypt/live/example.com/privkey.pem
```

### Run Nuxt in Dev Mode
``` bash
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up (optional -d)
```

### Run Nuxt in Prod Mode
``` bash
docker-compose up (optional -d)
```

