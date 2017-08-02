{ config, lib, pkgs, ... }:

with lib;

{
  config = (
    let
      export = n: v: "export ${n}=\"${toString v}\"";
      setenv = n: v: "setenv ${n} \"${v}\"";
      shEnvVarsStr = concatStringsSep "\n" (
        mapAttrsToList export config.home.sessionVariables
      );
      cshEnvVarsStr = concatStringsSep "\n" (
        mapAttrsToList setenv config.home.sessionVariables
      );
    in {
      home.file.".config/home-manager/env.sh".text = ''
        ${shEnvVarsStr}
      '';
      home.file.".config/home-manager/env.csh".text = ''
        ${cshEnvVarsStr}
      '';
    }
  );
}
