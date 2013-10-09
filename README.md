Magento2 Vagrant Box
================================
A simple way to get magento2 up and running

Usage
-------------------------
* Clone this repo and `cd` into it
* Initialize magento2 submodule: `git submodule update --init --recursive`
* start up virtual machine: `vagrant up`
* Point a host name to 192.168.56.10 in /etc/hosts e.g. 192.168.56.10 mage2.dev
* If all goes well you should see the install screen

Database Info
-------------------------
Username: root
Password: mage2
DB Name: mage2