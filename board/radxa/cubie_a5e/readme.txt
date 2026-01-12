Intro
=====

This default configuration will allow you to start experimenting with the
buildroot environment for the Radxa Cubie A5E. With the current configuration
it will bring-up the board, and allow access through the serial console.

Radxa Cubie A5E link:
https://radxa.com/products/cubie/a5e/

This configuration uses mainline U-Boot and mainline Linux kernel.
For ARM Trusted Firmware a development branch is used which is in the process
of being upstreamed.

How to build
============

    $ make radxa_cubie_a5e_defconfig
    $ make

Note: you will need access to the internet to download the required sources.

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX
  $ sudo sync

Where X is your SD card device.

Booting
=======

Insert the micro SDcard in your Radxa Cubie A5E and power it up.

The Radxa Cubie A5E has a 40-pin GPIO header. Its layout can be seen here:
https://docs.radxa.com/en/cubie/a5e/hardware-use/pin-gpio

The console is on UART0, which can be found on the following pins:

pin 6:  gnd
pin 8:  tx
pin 10: rx

Use the following settings to connect to the serial console: 115200 8N1

Official Documentation
======================

https://docs.radxa.com/en/cubie/a5e
