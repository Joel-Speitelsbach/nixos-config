#!/bin/sh
{ config, options, lib, modulesPath }:
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
  boot.loader.grub.extraEntries = ''
    menuentry "Ubuntu" {
      search --set=ubuntu --fs-uuid 5c3e493f-93ae-4809-9e1b-1b179075f2b0
      configfile "($ubuntu)/@/boot/grub/grub.cfg"
    }
    menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-C279-37B6' {
      insmod part_gpt
      insmod fat
      if [ x$feature_platform_search_hint = xy ]; then
        search --no-floppy --fs-uuid --set=root  C279-37B6
      else
        search --no-floppy --fs-uuid --set=root C279-37B6
      fi
      chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';
  
  # networking
  networking.networkmanager.enable = true;
  
  fileSystems = {
    "/mnt" =
      { device = "/dev/disk/by-uuid/5c3e493f-93ae-4809-9e1b-1b179075f2b0";
        fsType = "btrfs";
        options = btrfs_ssd_ops;
      };
    "/" =
      { options = btrfs_ssd_ops;
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
