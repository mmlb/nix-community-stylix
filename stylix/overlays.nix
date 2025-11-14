{
  lib,
  pkgs,
  config,
  options,
  ...
}:
{
  options.stylix.overlays.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.stylix.autoEnable;
    defaultText = lib.literalExpression "config.stylix.autoEnable";
    description = "Whether to enable theming for packages via overlays.";
    example = false;
  };

  imports = map (
    f:
    let
      file = import f;
      attrs =
        if builtins.isFunction file then
          file {
            inherit
              lib
              pkgs
              config
              options
              ;
          }
        else
          file;
    in
    {
      _file = f;
      options = attrs.options or { };
      config.nixpkgs.overlays = lib.mkIf config.stylix.overlays.enable [
        attrs.overlay
      ];
    }
  ) (import ./autoload.nix { inherit lib; } "overlay");
}
