#!/bin/sh
# Help is available in the configuration.nix(5) man page
{ ... }:
{
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./essential-system-properties.nix
      ./standard-properties.nix
      ./volatile.nix
      #./nvidia.nix
    ];

}
