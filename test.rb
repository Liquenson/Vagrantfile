Vagrant.configure("2") do |config|
    # Definición de la primera máquina virtual (web)
    config.vm.define "web" do |web|
      web.vm.box = "ubuntu/bionic64"
  
      # Configuración de red con reenvío de puertos
      web.vm.network :forwarded_port, guest: 80, host: 8080
  
      # Sincronización de carpetas
      web.vm.synced_folder "./web_content", "/var/www/html"
  
      # Aprovisionamiento con shell script
      web.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update -y
        sudo apt-get upgrade -y
        sudo apt-get install -y apache2
        sudo systemctl enable apache2
        sudo systemctl start apache2
      SHELL
  
      # Configuración específica del proveedor VirtualBox
      web.vm.provider :virtualbox do |v|
        v.memory = 1024
        v.cpus = 1
      end
    end
  
    # Definición de la segunda máquina virtual (app)
    config.vm.define "app" do |app|
      app.vm.box = "ubuntu/bionic64"
  
      # Configuración de red con IP privada
      app.vm.network :private_network, ip: "192.168.60.10"
  
      # Sincronización de carpetas
      app.vm.synced_folder "./app_code", "/home/vagrant/app"
  
      # Aprovisionamiento con shell script
      app.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update -y
        sudo apt-get upgrade -y
        sudo apt-get install -y nodejs npm
        cd /home/vagrant/app
        npm install
        npm start
      SHELL
  
      # Configuración específica del proveedor VirtualBox
      app.vm.provider :virtualbox do |v|
        v.memory = 2048
        v.cpus = 2
      end
    end
  
    # Definición de la tercera máquina virtual (db)
    config.vm.define "db" do |db|
      db.vm.box = "geerlingguy/centos7"
  
      # Configuración de red con IP privada
      db.vm.network :private_network, ip: "192.168.60.15"
  
      # Aprovisionamiento de PostgreSQL en la VM db
      db.vm.provision "shell", inline: <<-SHELL
        sudo yum update -y
        sudo yum install -y postgresql-server postgresql-contrib
        sudo postgresql-setup initdb
        sudo systemctl enable postgresql
        sudo systemctl start postgresql
        sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'password';"
        sudo -u postgres psql -c "CREATE DATABASE vagrantdb OWNER vagrant;"
      SHELL
  
      # Configuración específica del proveedor VirtualBox
      db.vm.provider :virtualbox do |v|
        v.memory = 1024
        v.cpus = 1
      end
    end
  end
  