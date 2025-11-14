{
  mkTarget,
  config,
  lib,
  ...
}:
mkTarget {
  name = "lightdm";
  humanName = "LightDM";

  extraOptions = {
    useWallpaper = lib.mkOption {
      type = lib.types.bool;
      default = config.stylix.image != null;
      defaultText = lib.literalExpression "config.stylix.image != null";
      description = "Whether to set the wallpaper for LightDM.";
      example = false;
    };
  };

  configElements =
    { cfg, image }:
    {
      services.xserver.displayManager.lightdm.background =
        lib.mkIf cfg.useWallpaper image;
    };
}
