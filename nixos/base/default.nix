{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openssl
    openconnect
  ];
}
