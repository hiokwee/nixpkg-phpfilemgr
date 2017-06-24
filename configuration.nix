# Edit this configuration file to define what should be installed on
# the system.  Help is available in the configuration.nix(5) man page
# or the NixOS manual available on virtual console 8 (Alt+F8).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # Define on which hard drive you want to install Grub.
   boot.loader.grub.device = "/dev/sda";

  # Networking settings
  networking = {
    hostName = "nix-host-99";
    enableIPv6 = false;
    interfaces.enp0s3 = {
      ipAddress = "192.168.0.99"; # static ip
      prefixLength = 24;
    };
    defaultGateway = "192.168.0.254";
    nameservers = [ "8.8.8.8" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ]; # ssh http ssl
    };
  };

  # Software needed
  environment.systemPackages = with pkgs; [
    curl vim php71Packages.composer
  ];

  # Set time zone.
  time.timeZone = "Pacific/Auckland";

  # Enable the OpenSSH, Clamav and Httpd daemon.
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes"; # Root user login
    };

    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };

    # Httpd with 3 virtual hosts
    httpd = {
      enable = true;
      enablePHP = true;
      adminAddr = "hiokwee@gmail.com";
      virtualHosts =
        let
          makeVirtualHost = { name, root }:
            { hostName = name;
              documentRoot = root;
              adminAddr = "hiokwee@gmail.com";
            };
        in map makeVirtualHost
          [ { name = "www.zalora.co.nz"; root = "/var/www/html/zalora"; }
            { name = "dev.zalora.co.nz"; root = "/var/www/html/zalora-dev"; }
            { name = "10.10.50.223"; root = "/var/www/html/zalora-test"; }
          ];
    };
  };

  # Create users
  users.extraUsers.hiokwee =
    { isNormalUser = true;
      home = "/home/hiokwee";
      description = "Chia Hiok Wee";
      extraGroups = [ "developer" ];
    };

}
