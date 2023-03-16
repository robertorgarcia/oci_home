#!/bin/bash
# Create user urbino
useradd -m urbino
# Inject ssh key for urbino
mkdir -p /home/urbino/.ssh
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKa+UH8dx3M0RDTVqAnB+Ew1b8+R5uRbRDYJP9YkUV6bUxgFbkD7TJlAGQ+rMObIO6Ko2K/wIgR8c+Kcl/TOBlEMqBEwdOQzJDzwNUXY8yOPCbgzL8Gh+r7T45SJHtclHjJWpt/dhMm087dKoj/K74KO9u/WGydDkrKv33/RIEw7ZsOHHfr5Wt72hts5N+Mn7QeqUZwWWzRubyQ0xofb2wgXZiCWx3+VTYelkcFCkPim9abe2GWDhCSiSnhAAcJAEmqRI48BPm2bi4WacirvIaR4kLL035Z3D+hoMW26hGfQGcMTmAUaQJAFulyUYyC3gNZ3QxwoWbvO6V1YWITTyWqjiusRKaRU0ziYwEKy3kCAFoDooz/jlDRKdO+hH0s7de4+HFytUmLJ81VtG3MV1LUSYjO5Gd6GjResoKSho+LEkYzFSvwz+az4oSyOh57mWCSQxvzHpl5jOutewz6V06RNqAWpg+wyhGOZphI4bOrgHcT7Pdseu7FxhErqq/cTM=" | sudo tee -a /home/urbino/.ssh/authorized_keys
sudo chown -R urbino:urbino /home/urbino/.ssh
sudo chmod 700 /home/urbino/.ssh
sudo chmod 600 /home/urbino/.ssh/authorized_keys
sudo echo 'urbino ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
