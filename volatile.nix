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
  
  programs.java.enable = true;
  #programs.java.package = pkgs.jre;
  
  ## sound
  hardware.pulseaudio.enable = true;
  #hardware.pulseaudio.support32Bit = true; 
  sound.enable = true;
  sound.enableOSSEmulation = true;
  
  networking.firewall.enable = false;
  
  #virtualbox
  # virtualisation.virtualbox.host.enable = true;
}
