## Creating preinstalled box in order to create local Haaukins

This is a repository to create pre-configured environment to run Haaukins on it.

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
cd sec0x/hkn-base/
./build.sh
cd ../
vagrant up
## after that you can ssh to vagrant easily
vagrant ssh

```
