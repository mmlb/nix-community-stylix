{ config, lib, ... }:
{
  options.stylix.targets.river.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.stylix.autoEnable;
    defaultText = lib.literalExpression "config.stylix.autoEnable";
    description = "Whether to enable theming for River.";
    example = false;
  };

  config = lib.mkIf (config.stylix.enable && config.stylix.targets.river.enable) {
    wayland.windowManager.river.settings =
      let
        inherit (config.lib.stylix) colors mkHexColor;
        inherit (config.stylix) cursor;
      in
      {
        border-color-focused = mkHexColor colors.base0D;
        border-color-unfocused = mkHexColor colors.base03;
        border-color-urgent = mkHexColor colors.base08;
        background-color = mkHexColor colors.base00;
        xcursor-theme = lib.mkIf (
          config.stylix.cursor != null
        ) "${cursor.name} ${toString cursor.size}";
      };
  };
}
