app.vm.network :forwarded_port, guest: 80, host: 8080
config.vm.synced_folder "path/to/host/folder", "/path/to/guest/folder"
app.vm.provision "shell", inline: <<-SHELL
  sudo apt-get update
  sudo apt-get install -y nginx
SHELL
config.vm.define "db" do |db|
    db.vm.box = "geerlingguy/centos7"
    db.vm.network :private_network, ip: "192.168.60.5"
    db.vm.provider :virtualbox do |v|
      v.memory = 1024
    end
  end