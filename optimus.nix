#!/bin/sh
{ pkgs, pkgs_i686, ... }:

let
  # nvidia packages to use
  nvidia   = pkgs     .linuxPackages_4_9.nvidia_x11;
  nvidia32 = pkgs_i686.linuxPackages_4_9.nvidia_x11;
in
{
  # disable card with bbswitch by default
  hardware.nvidiaOptimus.disable = true;
  # load kernel modules
  boot.extraModulePackages = [ nvidia.bin ];
  # install nvidia drivers in addition to intel one
  hardware.opengl.extraPackages   = [ nvidia.out   ];
  hardware.opengl.extraPackages32 = [ nvidia32.out ];
  
  services.udev.extraRules =
  ''
    KERNEL=="nvidia_uvm", RUN+="${pkgs.stdenv.shell} -c 'mknod -m 666 /dev/nvidia-uvm c $(grep nvidia-uvm /proc/devices | cut -d \  -f 1) 0'"
  '';
}

