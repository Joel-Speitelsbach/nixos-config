#!/bin/sh
{ pkgs, config, ... }:
{
  # system packages
  environment.systemPackages = with pkgs; [
    
    #standard graphical programs
    gnome3.gnome-disk-utility
    firefox
    
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
  
  #unfree
  nixpkgs.config.allowUnfree = true;
  
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
  };

  # Desktop Environment
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    autoLogin.user = "joel";
    autoLogin.enable = true;
  };
  services.gnome3 = {
    gnome-online-accounts.enable = false;
    gnome-online-miners.enable   = false;
    tracker.enable               = false;
    gnome-documents.enable       = false;
    chrome-gnome-shell.enable = true;
    gvfs.enable               = true;
  };
  nixpkgs.config.firefox.enableGnomeExtensions = true;

  # users 
  users.extraUsers.joel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    uid = 1000;
  };
  users.extraUsers.tester = {
    isNormalUser = true;
    uid = 1001;
  };
  
  # networking
  networking.hostName = "joels";
  services.samba.enable = true;
  
  #printing
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  
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
  
  #virtualization
  virtualisation.docker.enable = true;

  # time zone.
  time.timeZone = "Europe/Amsterdam";

}
