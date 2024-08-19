# Vagrant Development Environment

Este repositorio contiene los archivos de configuración para crear un entorno de desarrollo utilizando Vagrant.

## Requisitos Previos

- Vagrant: [Descargar e instalar Vagrant](https://www.vagrantup.com/downloads.html)
- VirtualBox: [Descargar e instalar VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Instrucciones de Uso

1. Clona este repositorio en tu máquina local:

```bash
git clone <URL_del_repositorio>

cd <nombre_del_directorio>
vagrant up
vagrant ssh
vagrant halt

Detalles de Configuración
La máquina principal utiliza Ubuntu y tiene Nginx instalado.
Se ha configurado un reenvío de puertos para redirigir el tráfico del puerto 8080 del host al puerto 80 del invitado.
Se ha sincronizado una carpeta entre el host y el invitado en la ruta /path/to/host/folder en el host y /path/to/guest/folder en el invitado.
Se ha definido una segunda máquina virtual llamada "db", que utiliza la imagen de CentOS 7.
La máquina "db" tiene asignada una dirección IP privada de 192.168.00.0 y 1024 MB de memoria.
