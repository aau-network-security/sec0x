# -*- mode: ruby -*-
# vi: set ft=ruby :

GOPATH = ENV['GOPATH'] || ""
if GOPATH == ""
    puts "GOPATH is undefined"
    exit!
end
## The directory of .ova files will be synced into VM machine
## which is created with the Vagrantfile
FRNTENDS = ENV['FRNTENDS']
if FRNTENDS == ""
    puts "FRNTENDS PATH is undefined"
    exit!
end
## The directory of configuration files will be synced into VM machine,
## which is created under your machine !
CONFIGS = ENV['CONFIGS']
if CONFIGS == ""
    puts "CONFIGS PATH is undefined"
    exit!
end
## Inside sec0x, there will be VMs (events VMs (created frontends))
## (so we may say nested VM situation),
VMDKS = ENV['VMDKS'] || ""
if VMDKS == ""
    puts "VMDKS is undefined"
    exit!
end

bridged_if = ENV['BRIDGE_IF'] || "enp0s25"
# puts "Bridged network interface: " + bridged_if
# puts "Synced Go directory: " + GOPATH

Vagrant.configure("2") do |config|
    config.vm.box = "hkn-base"
    config.vm.hostname = "sec0y"
    config.vm.network "public_network", bridge: bridged_if
    config.vm.network "forwarded_port", guest: 8081, host: 8081 ## for secure connection
    config.vm.network "forwarded_port", guest: 8080, host: 8080 ## for insecure connection
    config.vm.network "forwarded_port", guest: 5454, host: 5454
    config.vm.synced_folder VMDKS, "/scratch/virtualbox-vmdks"
    config.vm.synced_folder GOPATH, "/scratch/go"
    config.vm.synced_folder CONFIGS, "/scratch/configs"
    config.vm.synced_folder FRNTENDS, "/scratch/ova"
    config.ssh.forward_agent = true
    config.disksize.size='50GB' ## this might not be required, in order to use this function install VBOX plugin
                                ## vagrant plugin install vagrant-disksize
    config.vm.provider :virtualbox do |vb|
        # set name in virtualbox
        vb.name = "sec0y"
        vb.customize ["modifyvm", :id, "--memory", "4096"] ## might be customized according to your local computer resources
        # enable promiscuous mode on the public network
        #vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
end
