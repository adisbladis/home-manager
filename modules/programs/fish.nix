{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.fish;

in

{
  options = {
    programs.fish = {
      enable = mkEnableOption "Friendly Interactive SHell";

      configExtra = mkOption {
        default = "";
        type = types.lines;
        description = "Extra commands that should be added to config.fish.";
      };

      enableGreeting = mkOption {
        default = true;
        type = types.bool;
        description = "Enable the fish greeting message.";
      };
      
    };
  };

  config = (
    mkIf cfg.enable {
      home.file.".config/fish/config.fish".text = ''
        ${optionalString (!cfg.enableGreeting) "set -g fish_greeting \"\""}

        ${optionalString (config.home.sessionVariableSetter == "shell")
          "source ~/.config/home-manager/env.csh"}

        ${cfg.configExtra}
      '';
    }
  );
}
