# -*- mode: ruby -*-
# vi: set ft=ruby :

bridged_if = ENV['BRIDGE_IF'] || "enp0s25"
# puts "Bridged network interface: " + bridged_if
# puts "Synced Go directory: " + GOPATH

Vagrant.configure("2") do |config|
    config.vm.box = "nap-base"
    config.vm.hostname = "sec0x"
    config.vm.network "public_network", bridge: bridged_if
    config.vm.network "forwarded_port", guest: 8081, host: 7071 ## for secure connection
    config.vm.network "forwarded_port", guest: 8080, host: 7070 ## for insecure connection
    config.vm.network "forwarded_port", guest: 5454, host: 5353
     config.vm.network "forwarded_port", guest: 22, host: 4321
    config.ssh.forward_agent = true
    config.disksize.size='500GB' ## this might not be required, in order to use this function install VBOX plugin
                                ## vagrant plugin install vagrant-disksize
    config.vm.provider :virtualbox do |vb|
        # set name in virtualbox
        vb.name = "sec0x"
        vb.customize ["modifyvm", :id, "--memory", "131072"] ## might be customized according to your local computer resources
        # enable promiscuous mode on the public network
        #vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
end
