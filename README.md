vagrant-model
=============

A Vagrant project to setup a LAMP stack including Oracle Instant Client driver.

This project is only intended for my personal usage.

It is based on the sample Vagrant project made by Snatchfrigate (http://www.snatchfrigate.com/2012/07/16/installing-zend-server-and-mongodb-using-chef-and-vagrant/).
And the Chef recipe https://github.com/cla-rce/oracle-instantclient to install Oracle Instant Client.

What's included ?
=================

Based on the precise32 box, it includes :
* Zend Community Server from Zend
* MongoDb server
* Oracle Instant Client driver


Requirements
============
Before using this project, you must install Vagrant (http://www.vagrantup.com/).

How to use it
=============

* fork this project
* edit the app/conf.php.tmpl to set your database connection
* go to the vagrant directory
* enter 'vagrant up'
* open you web browser and go to http://10.0.0.2
* enjoy the result ;)

