# -*- mode: ruby -*-
# vi: set ft=ruby :


# Detect the current OS. node on windows needs some symlink magic to work.
module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  # For us, every thing thats not windows or mac is linux
  def OS.linux?
    OS.unix? and not OS.mac?
  end
end


Vagrant.configure(2) do |config|

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # base box
  config.vm.box = "ubuntu/vivid32"

  config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 4000, host: 4007

  # configure our vm's with puppet
  config.vm.provision :puppet do |puppet|

    if OS.windows?
      config.vm.provider "virtualbox" do |vb|
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
      end
      puppet.manifest_file = "windows.pp"

    else
      puppet.manifest_file = "linux.pp"
    end

  end

end
