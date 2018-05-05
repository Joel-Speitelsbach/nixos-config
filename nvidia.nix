#!/bin/sh
{ pkgs, pkgs_i686, ... }:

let
  # nvidia packages to use
  nvidia = pkgs.linuxPackages.nvidia_x11;
  nvidia32 = pkgs_i686.linuxPackages.nvidia_x11;
in
{
  nixpkgs.config.allowUnfree = true;
  # disable card with bbswitch by default
  hardware.nvidiaOptimus.disable = true;
  # load kernel modules
  boot.extraModulePackages = [ nvidia.bin ];
  # install nvidia drivers in addition to intel one
  hardware.opengl.extraPackages = [ nvidia.out ];
  hardware.opengl.extraPackages32 = [ nvidia32.out ];
}

