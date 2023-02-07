# Raspberry Pi Home Automaton

This repository contains all of the code to manage all things smart home. 

## Setup

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

Thne `configuration.yaml` file is copied to the remote server upon `make ansible` call. 

TODO: Currently, the `configuration.yaml` overwrites the existing one on the server which causes problems with `advanced.network_key`, as it gets regenerated each time. Create a way to solve this
TODO: Bring home assistant config.yaml into version control(?)
TODO: Back up home assistant config to S3
