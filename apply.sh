#!/bin/sh
config=$1

if [ $config == "home" ]
then
	echo "Building HomeManager configuration..."
	sudo nix build .#homeManagerConfigurations.brian.activationPackage && \
	echo "Activating HomeManager configuration..." && \
	./result/activate
elif [ $config == "system" ]
then
	echo "Building system configuration..."
	sudo nixos-rebuild switch --flake .
else
	echo "Missing target. Use script with 'home' or 'system' as argument."
fi
