#!/usr/bin/env bash

# version stuff
VBOX_VERSION="6.1"
# these two values should match!
VBOX_GUEST_VERSION="6.1.22"
VBOX_EXT_VERSION="6.1.22"
GO_VERSION="1.16.4"
COMPOSE_VERSION="1.22.0"
PROTOBUF_VERSION="3.6.1"

#update our repos
apt-get update -y

#install basic tools
apt-get install --no-install-recommends -yq apt-transport-https git vim sudo nmap tcpdump iproute2 net-tools curl wget unzip

# packages for all vbox related building
apt-get install --no-install-recommends -yq build-essential linux-headers-$(uname -r) wget


# lets install our guest additions
wget http://download.virtualbox.org/virtualbox/${VBOX_GUEST_VERSION}/VBoxGuestAdditions_${VBOX_GUEST_VERSION}.iso -O /tmp/guestadditions.iso
mkdir /media/VBoxGuestAdditions
mount -o loop,ro /tmp/guestadditions.iso /media/VBoxGuestAdditions
sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
umount /media/VBoxGuestAdditions
ls -l /media/VBoxGuestAdditions
rmdir /media/VBoxGuestAdditions
# install virtualbox
echo "deb https://download.virtualbox.org/virtualbox/debian stretch contrib" >> /etc/apt/sources.list.d/virtualbox.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
apt-get update
apt-get install -yq virtualbox-${VBOX_VERSION}
# extension pack
wget https://download.virtualbox.org/virtualbox/${VBOX_EXT_VERSION}/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_EXT_VERSION}.vbox-extpack -O /tmp/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_EXT_VERSION}.vbox-extpack
echo "y" | vboxmanage extpack install /tmp/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_EXT_VERSION}.vbox-extpack
# final stuff
/sbin/vboxconfig
# setup folder for virtualbox-vmdks
mkdir -p /scratch/virtualbox-vmdks
su vagrant -c 'vboxmanage setproperty machinefolder /scratch/virtualbox-vmdks'

# remove packages for all vbox related building
apt-get remove --auto-remove -y build-essential linux-headers-$(uname -r)

#install golang
wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/golang.tar.gz
tar -C /usr/local -xzf /tmp/golang.tar.gz
rm /tmp/golang.tar.gz

#make dirs for golang
mkdir -p /scratch/go/src

#path stuff for golang
echo 'PATH="$PATH:/usr/local/go/bin"' >> /home/vagrant/.profile
echo 'export GOPATH="/scratch/go"' >> /home/vagrant/.profile
echo 'export PATH="$PATH:$GOPATH/bin"' >> /home/vagrant/.profile

#prompt for stuff
export GIT_TERMINAL_PROMPT=1

#git stuff
printf "[url \"git@github.com:\"]\n\tinsteadOf = https://github.com/" > /home/vagrant/.gitconfig
chown vagrant:vagrant /home/vagrant/.gitconfig

#install docker
curl https://get.docker.com | sh -
usermod -aG docker vagrant

#setup docker-compose
curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# protobuf stuff
go get -u github.com/golang/protobuf/protoc-gen-go
wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip -O /tmp/protobuf.zip
unzip /tmp/protobuf.zip -d /tmp/protobuf
mv /tmp/protobuf/bin/* /usr/local/bin/
mv /tmp/protobuf/include/* /usr/local/include/

# fix permissions for scratch
chown vagrant:vagrant -R /scratch

#cleanup files
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
apt-get clean

#cleanup
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
cat /dev/null > ~/.bash_history && history -c && exit
