{
  nixvirt,
  ...
}:

{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.looking-glass-client.enable = true;
}
