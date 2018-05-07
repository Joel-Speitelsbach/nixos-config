#!/bin/sh
{ pkgs, ... }:
{
  # packages
  environment.systemPackages = with pkgs; [
  
    #libreoffice-still
    
    # development
    #diffuse
    
    #multimedia
    #vlc
  ];
  
  #virtualbox
  # virtualisation.virtualbox.host.enable = true;
  
  # kernel version
  boot.kernelPackages = pkgs.linuxPackages_4_9;
}
