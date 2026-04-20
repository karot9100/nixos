{ lib, ... }:

{
  options.mymodules.mainUser = lib.mkOption {
    type = lib.types.str;
    default = "simon";
    description = "Primary user for per-user activation scripts, tmpfiles, etc.";
  };
}
