# sao

sao is a floating window manager forked from dwm, and heavily
inspired by rio.

## Requirements

In order to build sao you need the Xlib header files.

## Installation

Edit config.mk to match your local setup (sao is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install sao (if
necessary as root):

    make clean install

## Running sao

Add the following line to your .xinitrc to start sao using startx:

    exec sao

In order to connect sao to a specific display, make sure that
the DISPLAY environment variable is set correctly, e.g.:

    DISPLAY=foo.bar:1 exec sao

(This will start sao on display :1 of the host foo.bar.)

In order to display status info in the bar, you can do something
like this in your .xinitrc:

    while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
    do
    	sleep 1
    done &
    exec sao

## Configuration

The configuration of sao is done by creating a custom config.h
and (re)compiling the source code. Of course, right now there
isn't much to configure...
