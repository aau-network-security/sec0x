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

Set some required environment variables into your bash profile before running the box under vagrant
```
export VMDKS=...
export VMDKS=...
export CONFIGS=...
export FRNTENDS=....
```
After having set of given variables in your bash profile, you are good to go !
```console 
HKN_HOST=localhost HKN_SSL_OFF=true go run app/client/main.go event create boot -n "Boot " -a 5 -c 10 -e xss,scan,hb,phish -f kali
```
HKN_HOST=localhost HKN_SSL_OFF=true go run app/client/main.go event create boot -n "Boot " -a 5 -c 10 -e xss,scan,hb,phish -f kali

**Regarding to flags on command *

```
(-n or --name): Title of the event
(-a or --available): Requested number of labs
(-c or --capacity): Capacity of requested event
(-e or --exercises): Set of exercise tags (which are defined under exercise.yml file)
(-f or --frontend) : Virtual machine to use
```
### Setting paths and sync them with your local

Before building the box, make sure that the following environment variables are defined:
- `GOPATH`- your default GOPATH should be in synced_folder format
- `BRIDGE_IF` - the bridged network interface. If empty, `enp0s25` is used    
- `VMDKS` - this is the place where your created VMs take place
- `CONFIGS`- configuration files directory should be specified
- `FRNTENDS`- in order to create events, frontends (.ova) files should be placed under defined directory (e.g : /Users/demo/FRNTENDS/)

### Demonstration of steps

[![asciicast](https://asciinema.org/a/LDaeaNm1I3mxfXJSmUC7q4cHl.svg)](https://asciinema.org/a/LDaeaNm1I3mxfXJSmUC7q4cHl)


### Build required image with following command

```
cd sec0x/nap-base/
./build.sh
cd ../
vagrant up
## after that you can ssh to vagrant easily
vagrant ssh

```

### Examples to configuration files

Can be observed from following place:

- [Example Daemon Configuration Files](https://github.com/aau-network-security/haaukins/blob/master/app/daemon/readme.md)
