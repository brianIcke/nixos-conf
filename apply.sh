#!/bin/sh
apply_home()
{
	echo "Building HomeManager configuration..."
	home-manager switch --flake .#brian@BrianTUX 

  # Alternative method
	#sudo nix build .#homeManagerConfigurations.brian.activationPackage && \
	#echo "Activating HomeManager configuration..." && \
	#./result/activate
}

apply_system()
{
	echo "Building system configuration..."
	sudo nixos-rebuild switch --flake .
}

config=$1

if [ -z "$config" ]
then
  apply_home &&
  apply_system
elif [ $config = "home" ]
then
  apply_home
elif [ $config = "system" ]
then
  apply_system
else
	echo "Missing target. Use script with 'home' or 'system' as argument."
fi

