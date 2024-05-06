#!/bin/sh
ln -s $PWD/bspwm/bspwmrc $HOME/.config/bspwm/bspwmrc \
&& echo Created symlink for bspwm config

ln -s $PWD/sxhkd/sxhkdrc $HOME/.config/sxhkd/sxhkdrc \
&& echo Created symlink for sxhkd config

ln -s $PWD/polybar/config.ini $HOME/.config/polybar/config.ini \
&& echo Created symlink for polybar config

ln -s $PWD/polybar/launch.sh $HOME/.config/polybar/launch.sh \
&& echo Created symlink for polybar launch script
