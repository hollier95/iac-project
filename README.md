# IAC-PROJECT


This project has been performed during my master degree.

The goal of this project was to build a Google Cloud infrastructure with basic technologies we need to deploy servers automatically, and monitor them.

I decided to use terraform to configure GCP part, and ansible for OS one.

To manage to execute all these scripts, you will have to have built :
- Google Cloud Platform environment, with compute engine activated
- Gitlab EE/CE server
- Gitlab runners registered with yout Gitlab projects 
- Servers are able to communicate between them with https(443) and ssh(22)

First, clone [iac-project](https://github.com/hollier95/iac-project/tree/main/iac-project).

## In terraform folder

You have two files :
 - .gitlab-ci.yml : the goal of this one is to manage deploy pipelines through Gitlab CI/CD
 - main.tf : this one is the terraform's configuration file, very basic, but all what we need

You have to edit these lines regarding your configuration :

- **.gitlab-ci.yml** :

In this file, you will see this variable :**$TERRAFORM_SERVICEACCOUNT** It must be sat on your [Gitlab CI/CD variables](https://docs.gitlab.com/ee/ci/variables/)

It concerns Google Cloud Platform service account, if you don't know how to create it, let's read some [Google docs ...](https://cloud.google.com/iam/docs/service-accounts?hl=fr)
```shell
    -  echo $TERRAFORM_SERVICEACCOUNT | base64 -d > ./creds/serviceaccount.json
```

- **main.tf** :
```shell
  project = "XXXXXXX" # project id, looks like this : foo-XXXXXX
  region  = "XXXXXXX" # depends on where you want your server be located
  zone    = "XXXXXXX" # more precise to indicate your server location
```

```shell
  name         = "foo" # just indicate your server name here
```

## In ansible folder 

Each service configuration is located in a .yml file, they contain packets installation and their configuration.

- **templates/files** : contains jinja2 files regarding apache, snmpd and elastic-agent configuration files.

You have nothing to modify to make the config work.

- **vars** : contain a default.yml which defines some jinja variables
here you have to modify these lines regarding your configuration :
```shell
app_user: "XXX" 
http_host:  "{{ ansible_hostname }}.foo.org"
http_conf: "{{ ansible_hostname }}.foo.org.conf"
```
```shell
client_centreon: "foo"
ipclient_centreon: "X.X.X.X"
```
- **.gitlab-ci.yml** : the pipelines' manager
In this file, you have to consider two variables which have to be sat on Gitlab CI/CD.

It concerns these lines : 
```shell
    - echo "$ANSIBLE_SSH_PRIV" > ~/.ssh/ansible.key
    - echo -e "Host *\n\tUser $ANSIBLE_USER\n\tIdentityFile ~/.ssh/ansible.key" >> ~/.ssh/config
```
**$ANSIBLE_SSH_PRIV** is the private ssh key generated to clone gitlab repositories
**$ANSIBLE_USER** is the user linked to your ssh key

- **apache.yml** : these yaml file installs apache packets and import jinja2 files from **templates/files**, it enables SSL and Rewrite module, and allow 80 and 443 port on internal firewall.
