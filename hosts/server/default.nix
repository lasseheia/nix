{
  imports = [
    ../../modules/nixos
    ../../modules/zfs
  ];

  users.users.lasse.isNormalUser = true;

  users.users.lasse.group = "lasse";
  users.groups.lasse = {};
}
