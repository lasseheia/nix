{ lib, ... }:

{
  options = {
    disk_name = lib.mkOption { type = lib.types.str; };
  };
}
