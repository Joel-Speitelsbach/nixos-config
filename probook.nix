#!/bin/sh
{ pkgs, ... }:
let
  ntfsMount = uuid:
    { device = "/dev/disk/by-uuid/" + uuid;
      fsType = "ntfs-3g";
      options =  ["x-gvfs-show" "uid=1000"];
    };
in {
  # kernel version
  boot.kernelPackages = pkgs.linuxPackages_4_9;
  
  # nvidia
  hardware.bumblebee.enable = true;
  hardware.opengl.driSupport32Bit = true;
  imports =
    [ #./optimus.nix
    ];

  # boot loader
  boot.loader.timeout = 1;
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
  
  # security
  security.sudo.wheelNeedsPassword = false;
  system.autoUpgrade.enable = true;
  
  fileSystems = {
    "/mnt" =
      { device = "/dev/vg/root";
      };
    "/Store" =
      { device = "/dev/rot/store";
        options = ["x-gvfs-show"];
      };
    "/boot/efi" =
      { device = "/dev/nvme0n1p1";
        options = ["noauto"];
      };
    "/WinMain"    = ntfsMount "7F7445910E23C5AB";
    "/WinStorage" = ntfsMount "42D2DD07D2DD0059";
  };
}
