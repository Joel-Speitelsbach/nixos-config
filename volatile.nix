#!/bin/sh
{ pkgs, ... }:
{
  # packages
  environment.systemPackages = with pkgs; [
  
    #libreoffice-still
    
    # development
    #diffuse
    #python3Packages.tensorflowWithCuda
    
    #multimedia
    #vlc
    
  ];
  
  #virtualbox
  # virtualisation.virtualbox.host.enable = true;
}
