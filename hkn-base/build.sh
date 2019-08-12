#!/bin/bash
vagrant box remove --force hkn-base
vagrant destroy --force
vagrant up --provision
vagrant package --output hkn-base.box
vagrant box add hkn-base.box --name hkn-base
rm hkn-base.box
