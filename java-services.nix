#!/bin/sh
  
{
  services.tomcat.enable =true;
  services.jboss.enable = true;
  nixpkgs.config.permittedInsecurePackages = [
   "jboss-as-7.1.1.Final"
  ];
  services.jboss.deployDir = "/home/joel/Java/jboss-deploy";
}
