#!/bin/sh
{ pkgs, ... }:
{
  # packages
  environment.systemPackages = with pkgs; [
    atom
    chromium
    efibootmgr
    gdb
    geany
    geckodriver
    gimp
    git
    gnumake
    gparted
    imagemagick
    keepassx2
    libreoffice-still
    lz4
    lzop
    ntfs3g
    p7zip
    racket
    trash-cli
    vlc
    wine
  ];
  
  programs.java.enable = true;
  #programs.java.package = pkgs.jre;
  
  ## sound
  #hardware.pulseaudio.enable = false;
  hardware.pulseaudio.support32Bit = true; 
  sound.enable = true;
  sound.enableOSSEmulation = true;
  
  ## firewall
  networking.firewall.enable = false;
  
  ## virtualization
  # virtualisation.virtualbox.host.enable = true;  
  # virtualisation.docker.enable = true;
}
