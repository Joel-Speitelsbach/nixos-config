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
                            #    .lxqt
  services.xserver.displayManager.gdm = {
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
    extraGroups = [ "wheel" "networkmanager" "audio" "scanner" "lp"];
    uid = 1000;
  };
  users.extraUsers.tester = {
    isNormalUser = true;
    uid = 1001;
  };
  
  # networking
  networking.hostName = "joels";
  services.samba.enable = true;
  services.samba.enableNmbd     = true;
  services.samba.enableWinbindd = true;
  services.samba.nsswins        = true;
  
  # printing / scanning
  services.printing.enable = true;
  #services.avahi.enable = true;
  #services.avahi.nssmdns = true;
  services.printing.drivers = [pkgs.gutenprint pkgs.hplip];
  #hardware.sane.enable = true;  #didnt work..
  #services.saned.enable = true; #the fist time
  
  # temp & cleaning
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

}
