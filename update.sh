#!/bin/sh
args=$1

if [ -z "$args" ]
then
nix flake update
elif [ $args = "--upgrade" ]
then
nix flake update
# Apply changes (home & system)
./apply.sh
else
  echo "Invalid argument: $args"
fi
