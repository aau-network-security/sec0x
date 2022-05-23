# -*- mode: ruby -*-
# vi: set ft=ruby :

bridged_if = ENV['BRIDGE_IF'] || "enp0s25"
# puts "Bridged network interface: " + bridged_if
# puts "Synced Go directory: " + GOPATH

Vagrant.configure("2") do |config|
    config.vm.box = "hkn-base"
    config.vm.hostname = "sec0x"
    config.env.enable # enable .env variable to be used 
    config.vm.network "public_network", bridge: bridged_if
    config.vm.network "forwarded_port", guest: 8081, host: 8081 ## for secure connection
    config.vm.network "forwarded_port", guest: 8080, host: 8080 ## for insecure connection
    config.vm.network "forwarded_port", guest: 5454, host: 5454
    config.vm.network "forwarded_port", guest: 8000, host: 8000
    config.vm.network "forwarded_port", guest: 8003, host: 8003
    config.vm.network "forwarded_port", guest: 5432, host: 5432
    config.vm.network "forwarded_port", guest: 50095, host: 50095
    config.vm.network "forwarded_port", guest: 27017, host: 27017
    # 50051 is used for launchd process on macOS 
    config.vm.network "forwarded_port", guest: 50051, host: 1234
    config.vm.network "forwarded_port", guest: 9999, host: 9999
    # vagrant plugin install vagrant-env
    # in order to use ENV file we need to install vagrant-env 
    config.vm.synced_folder ENV['VMDKS'], "/scratch/virtualbox-vmdks"
    config.vm.synced_folder ENV['GO_PATH'], "/scratch/go"
    config.vm.synced_folder ENV['HKND_CONFIGS'], "/scratch/configs"
    config.vm.synced_folder ENV['HKND_PROJECTS'], "/scratch/projects"
    config.vm.synced_folder ENV['HKND_FRONTENDS'], "/scratch/ova"
    config.ssh.forward_agent = true
    config.disksize.size='50GB' ## this might not be required, in order to use this function install VBOX plugin
                                ## vagrant plugin install vagrant-disksize
    config.vm.provider :virtualbox do |vb|
        # set name in virtualbox
        vb.name = "sec0x"
        vb.customize ["modifyvm", :id, "--memory", "4096"] ## might be customized according to your local computer resources
        # enable promiscuous mode on the public network
        #vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
end
