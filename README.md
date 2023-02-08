# Raspberry Pi Home Automaton

This repository contains all of the code to manage all things smart home. 

## Setup

### Secrets

There are two files you need to create locally:

`secrets.yaml` - containing the `NETWORK_KEY` for the zigbee2mqtt config.

`infrastructure/secrets.tfvars` - containing the secrets required for Terraform, i.e.:
- key = Key of the state file
- bucket = Bucket containing the terraform state file
- region = Region where the state file is kept

### SSH

If you need to change the SSH key or create one from scratch, you can use `ssh-keygen`, then specify a filepath in the subsequent prompt. 

Within the remote host you will then need to ensure that you have a user set up, using the following commands if necessary:

```
getent passwd # will list all users, so...
getent passwd | grep <<USER>> # will tell us if user exists

sudo useradd -m <<USER>> # -m flag adds home dir
sudo passwd <<USER>>
```

Once you have the user set up, you can run `ssh-copy-id -i <<FILEPATH>> <<USER>>@ubuntu-rpi`

The -i switch specifies where the key file is. 

## Usage

The `Makefile` contains all of the commands required. 

## Zigbee2mqtt

Thne `configuration.yaml.j2` file is copied to the remote server upon `make ansible` call, but it is templated to insert secrets such as the `network_key`. 

TODO: Bring home assistant config.yaml into version control(?)

TODO: Back up home assistant config to S3
