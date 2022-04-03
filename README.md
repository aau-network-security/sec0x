## Creating preinstalled box in order to create local Haaukins

This is a repository to create pre-configured environment to run Haaukins on it.

### Prerequisites

Before attempting to create pre-configured VM on your local computer, make sure that required software installed to your computer

- __Docker__
  - *Linux*   : https://docs.docker.com/install/linux/docker-ce/ubuntu/
  - *Windows* : https://docs.docker.com/docker-for-windows/install/
  - *MacOS*   : https://docs.docker.com/v17.12/docker-for-mac/install/

- __Golang__ (https://golang.org/dl/)
- __Vbox__   (https://www.virtualbox.org/wiki/Downloads)
- __Vagrant__ (https://www.vagrantup.com/downloads.html)

In addition mentioned tools above, you should be sure that you have enough resources (CPU, Memory).

_This repository might not be needed if you want to use your actual Linux environment instead of running  VM under your machine_


Make sure that you have pre-configured box installed in your local computer by given instructions from the repo sec0x

Include your local paths to sync folders with Virtual environment. Update [.env.example](.env.example) and rename it to ```.env``` in the same place where [Vagrantfile](./Vagrantfile) is located. 

Content of example .env file: 
```raw 
GO_PATH=$HOME/go 
VMDKS=<path-to-vmdks-folder-in-your-local-computer>
HKND_CONFIGS=<path-to-configs-folder-in-your-local-computer>
HKND_FRONTENDS=<path-to-frontends-folder-in-your-local-computer>
HKND_PROJECTS=<path-to-projects-folder-in-your-local-computer>
```
## Check this requirements before building the box

Before building the box make sure about followings:
 
 - Generated ```.env``` file before building the box as described above. 

- Installed plugins to have working Vagrantfile
  ```bash 
   # install vagrant-disksize  
   $ vagrant plugin install vagrant-disksize 
   # install vagrant-env
  ```

### Demonstration of steps

Following cast is showing the process of making the vagrant up and ready after, you have cloned the repository. 

[![asciicast](https://asciinema.org/a/LDaeaNm1I3mxfXJSmUC7q4cHl.svg)](https://asciinema.org/a/LDaeaNm1I3mxfXJSmUC7q4cHl)


### Build required image with following command 

```
git clone https://github.com/aau-network-security/sec0x
cd sec0x/hkn-base/
./build.sh
cd ../
vagrant up
## after that you can ssh to vagrant easily
vagrant ssh

```


### Examples to configuration files

Can be observed from following place:

- [Example Daemon Configuration Files](https://github.com/aau-network-security/haaukins/wiki/Configuring-the-daemon)
