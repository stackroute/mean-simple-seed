Vagrant.configure(2) do |config|

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # base box
  config.vm.box = "debian/jessie64"
  config.vm.box_check_update = false


  config.vm.synced_folder ".", "/vagrant/src"
  config.vm.network "forwarded_port", guest: 4000, host: 4000

  config.vm.provision "shell", path: "vagrant_provision.sh"

end
