# IAC-PROJECT


This project has been performed during my master degree.

The goal of this project is to build a Google Cloud infrastructure with basic technologies we need to deploy servers automatically, and monitor them.

I decided to use terraform to configure GCP part, and ansible for OS one.

To manage to execute all these scripts, you will have to have built :
- Google Cloud Platform environment, with compute engine activated
- Gitlab EE/CE server
- Gitlab runners registered with yout Gitlab projects 

First, clone [iac-project](https://github.com/hollier95/iac-project/tree/main/iac-project).

## In terraform folder

You have two files :
 - .gitlab-ci.yml : the goal of this one is to manage deploy pipelines through Gitlab CI/CD
 - main.tf : this one is the terraform's configuration file, very basic, but all what we need

You have to edit these lines regarding your configuration :

.gitlab-ci.yml

In this file, you will see this variable :**$TERRAFORM_SERVICEACCOUNT** It must be sat on your [Gitlab CI/CD variables](https://docs.gitlab.com/ee/ci/variables/)

It concerns Google Cloud Platform service account, if you don't know how to create it, let's read some [Google docs ...](https://cloud.google.com/iam/docs/service-accounts?hl=fr)
```shell
    -  echo $TERRAFORM_SERVICEACCOUNT | base64 -d > ./creds/serviceaccount.json
```

main.tf :
```shell
  project = "XXXXXXX" # project id, looks like this : foo-XXXXXX
  region  = "XXXXXXX" # depends on where you want your server be located
  zone    = "XXXXXXX" # more precise to indicate your server location
```

```shell
  name         = "foo" # just indicate your server name here
```

## In ansible folder 
