#!/bin/sh
{ config, options, lib, modulesPath, fileSystems }:
let 
  btrfs_ssd_ops = [ "discard" ];
in
{
  # bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
    efiSupport = true;
    #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
    device = "nodev";
  };
  
  # networking
  networking.networkmanager.enable = true;
  
  fileSystems = {
    "/" =
      { fsType = "btrfs";
        options = btrfs_ssd_ops;
      };
    "/mnt" =
      { fsType = "btrfs";
        options = btrfs_ssd_ops;
      };
    #"/boot/efi" =
      #{ device = "/dev/nvme0n1p1";
      #};
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03";
}
