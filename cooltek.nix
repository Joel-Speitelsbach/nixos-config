#!/bin/sh
{ pkgs, ... }:
{
  # packages
  environment.systemPackages = with pkgs; [
  
    #libreoffice-still
  ];

  boot.loader.grub.extraEntries = ''
    menuentry "Ubuntu" {
      search --set=ubuntu --fs-uuid fb1a59f0-ad32-4bd3-8a93-cc413a599686
      configfile "($ubuntu)/@/boot/grub/grub.cfg"
    }
    menuentry 'Windows Boot Manager' --class windows --class os $menuentry_id_option 'osprober-efi-4A6E-2CB1' {
      insmod part_gpt
      insmod fat
      search --no-floppy --fs-uuid --set=root 4A6E-2CB1
      chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';
  
  fileSystems."/mnt" =
    { device = "/dev/disk/by-uuid/fb1a59f0-ad32-4bd3-8a93-cc413a599686";
    };
}
