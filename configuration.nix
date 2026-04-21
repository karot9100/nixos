{ lib, ... }:

let
  hostname = lib.removeSuffix "\n" (builtins.readFile /etc/hostname);

  hosts = {
    "simon" = ./hosts/simon;
    "optiplex" = ./hosts/server;
    "nixos-server" = ./hosts/server;
  };
in

{

  imports = [
    (hosts.${hostname} or (throw ''
      No host configuration found for hostname "${hostname}".
      Add an entry to the 'hosts' attrset in /etc/nixos/configuration.nix.
    ''))
  ];

}
