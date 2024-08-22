Vagrant.configure("2") do |config|
  # Definición de la primera máquina virtual (app)
  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/bionic64"

    # Configuración de red con reenvío de puertos
    app.vm.network :forwarded_port, guest: 80, host: 8080

    # Sincronización de carpetas
    app.vm.synced_folder "./host_folder", "/vagrant_data"

    # Aprovisionamiento con shell script
    app.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update -y
      sudo apt-get upgrade -y
      sudo apt-get install -y nginx
      sudo systemctl enable nginx
      sudo systemctl start nginx
    SHELL

    # Configuración específica del proveedor VirtualBox
    app.vm.provider :virtualbox do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  # Definición de la segunda máquina virtual (db)
  config.vm.define "db" do |db|
    db.vm.box = "geerlingguy/centos7"

    # Configuración de red con IP privada
    db.vm.network :private_network, ip: "192.168.60.5"

    # Aprovisionamiento de MySQL en la VM db
    db.vm.provision "shell", inline: <<-SHELL
      sudo yum update -y
      sudo yum install -y mysql-server
      sudo systemctl enable mysqld
      sudo systemctl start mysqld
      sudo mysql_secure_installation
    SHELL

    # Configuración específica del proveedor VirtualBox
    db.vm.provider :virtualbox do |v|
      v.memory = 1024
      v.cpus = 1
    end
  end
end
