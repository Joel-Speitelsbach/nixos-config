#!/bin/sh
{ pkgs, config, ... }:
{
  # system packages
  environment.systemPackages = with pkgs; [
    
    #standard graphical programs
    gnome3.gnome-disk-utility
    
    #gnome specific
    gksu
    
    #fonts
    #freefont_ttf
    
    # development
    #gnumake
    
    #base tools
    encfs
    htop
  ];
  
  #flash player
  #nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.firefox.enableAdobeFlash = true;
  
  # Gnome exclude Packages
  environment.gnome3.excludePackages = with pkgs.gnome3; [
    evolution
    accerciser
    gnome-packagekit
    gnome-software
    gnome-maps
    gnome-weather
    gnome-photos
    gnome-nettool
    gnome-shell-extensions
    gnome-music
    yelp
    totem
    epiphany
  ];
  
  # X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "de";
    xkbVariant = "neo";
    autoRepeatDelay = 200;
    autoRepeatInterval = 15;
    #monitorSection = ''
      #Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
    #'';
  };

  # Desktop Environment
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    autoLogin.user = "joel";
    autoLogin.enable = true;
  };
  services.gnome3 = {
    gnome-online-accounts.enable = false;
    gnome-online-miners.enable = false;
    tracker.enable = false;
    gnome-documents.enable = false;
  };

  # users 
  users.extraUsers.joel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    uid = 1000;
  };
  users.extraUsers.tester = {
    isNormalUser = true;
    uid = 1001;
  };
  
  # networking
  networking.hostName = "joels";
  
  #temp & cleaning
  boot.cleanTmpDir = true;
  services.journald.extraConfig = "SystemMaxUse=50M";

  # console properties
  programs.bash.enableCompletion = true;
  i18n = {
    consoleKeyMap = "neo";
    defaultLocale = "en_US.UTF-8";
    # supportedLocales = ["en_US.UTF-8" "de_DE.UTF-8"];
  };

  # time zone.
  time.timeZone = "Europe/Amsterdam";
  
  hardware.bumblebee.enable = true;
  nixpkgs.config.allowUnfree = true;
  
  #fileSystems."/boot" =
    #{ device = "/dev/disk/by-uuid/C279-37B6";
    #};

}
