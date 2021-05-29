============
Sandbox repo
============

:abstract:

    Sandbox to try out coding tools

:Author: baldr9

.. contents:: Table of Contents
.. section-numbering::

Packages and applications to install
====================================

Python tools
------------

- Make sure python (python 2.7x) and python3 (3.x) are installed

  + shell command ``which python`` returns ``/usr/bin/python`` and it starts python 2.7.x

  + shell command ``which python3`` returns ``/usr/bin/python3`` and it starts python 3.6.x

- Packages::

	# update package list
	sudo apt-get update

	# fix issues with package manager
	sudo apt --fix-broken install

	# install pip
	sudo apt install python-pip

	# install virtualenv, tool for managing python versions
	# these install locally for user in ~/.local/, e.g. ~/.local/bin/virtualenv
	pip install virtualenv

	# install pipenv, tool for managing python versions
	pip install --user pipenv

	# view restructured text formated files
	pip install restview

	# Fabric 1.x, optional for Ion Inspector, this is local install ~/.local
	pip install 'fabric<2.0'
	# Ubuntu package
	sudo apt-get install fabric

	# postgres client tools
	sudo apt-get install postgresql-client-common
	sudo apt-get install postgresql-client

Docker
------

- Install `Docker on VM <https://docs.docker.com/engine/install/ubuntu/>`__

- Install `Docker Compose on VM <https://docs.docker.com/compose/install/>`__

- docker-compose is a handy tool to wrap docker commands

- Docker files ``*.yml``

  + base config::

	docker-compose.yml

  + dev config::

	# Note: Gets used by default
	docker-compose.override.yml

  + production::

	# Note: You specify special flags for production
	docker-compose.prod.yml
	docker-compose.yml


