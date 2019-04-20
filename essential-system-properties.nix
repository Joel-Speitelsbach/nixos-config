#!/bin/sh
{ config, options, lib, modulesPath, fileSystems }:
let 
  btrfs_ssd_ops = [ "discard" "noatime" ];
in
{
  # bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
      efiSupport = true;
    device = "nodev";
  };
  
  
  # networking
  networking.networkmanager.enable = true;
  
  
  # filesystems
  fileSystems = {
    "/" =
      { fsType = "btrfs";
        options = btrfs_ssd_ops;
      };
    "/mnt" =
      { fsType = "btrfs";
        options = btrfs_ssd_ops;
      };
  };


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03";
}
