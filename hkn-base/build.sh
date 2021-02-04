#!/bin/bash
vagrant box remove --force nap-base
vagrant destroy --force
vagrant up --provision
vagrant package --output nap-base.box
vagrant box add nap-base.box --name nap-base
rm nap-base.box
