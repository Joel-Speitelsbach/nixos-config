#!/bin/sh
{ pkgs, ... }:
{
  # kernel version
  boot.kernelPackages = pkgs.linuxPackages_4_9;
  
  # nvidia
  hardware.bumblebee.enable = true;
  hardware.opengl.driSupport32Bit
  imports =
    [ ./optimus.nix
    ];

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
}
