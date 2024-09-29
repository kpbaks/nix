{ config, lib, ... }:
let
  cfg = config.services.glance.catppuccin;
  enable = cfg.enable && config.services.glance.enable;
  themes = {
    frappe = {
      background-color = "229 19 23";
      contrast-multiplier = 1.2;
      primary-color = "222 74 74";
      positive-color = "96 44 68";
      negative-color = "359 68 71";
    };
    macchiato = {
      #   theme:
      background-color = "232 23 18";
      contrast-multiplier = 1.2;
      primary-color = "220 83 75";
      positive-color = "105 48 72";
      negative-color = "351 74 73";
    };
    mocha = {
      background-color = "240 21 15";
      contrast-multiplier = 1.2;
      primary-color = "217 92 83";
      positive-color = "115 54 76";
      negative-color = "347 70 65";
    };
    latte = {
      light = true;
      background-color = "220 23 95";
      contrast-multiplier = 1.0;
      primary-color = "220 91 54";
      positive-color = "109 58 40";
      negative-color = "347 87 44";
    };
  };
in
{
  options.services.glance.catppuccin = lib.ctp.mkCatppuccinOpt { name = "glance"; };

  config = lib.mkIf enable {
    services.glance.settings.theme = themes.${cfg.flavor};
  };
}
