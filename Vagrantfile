MACHINES = {
  :"pam" => {
              :box_name => "ubuntu/jammy64",
              :cpus => 4,
              :memory => 4096,
              :ip => "192.168.56.10",
            }
}

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    #config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.network "private_network", ip: boxconfig[:ip]
    config.vm.define boxname do |box|
      box.vm.box = boxconfig[:box_name]
      box.vm.box_version = boxconfig[:box_version]
      box.vm.host_name = boxname.to_s
      box.vm.network "forwarded_port", guest: 22, host: 22
      box.vm.provider "virtualbox" do |v|
        v.memory = boxconfig[:memory]
        v.cpus = boxconfig[:cpus]
      end
      box.vm.provision "shell", inline: <<-SHELL
          sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
          systemctl restart sshd.service
  	  SHELL
      box.vm.provision "shell", path: "./step1.sh"
      box.vm.provision "shell", path: "./step2.sh"
      box.vm.provision "shell", path: "./step3.sh"
      #box.vm.provision "shell", reboot: true
    end
  end
end
