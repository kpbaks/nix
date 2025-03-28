let
  inherit (builtins) concatStringsSep attrValues mapAttrs;
  inherit (import <nix/utils.nix>) optionalString squash;
in

builtinsInfo:
let
  showBuiltin =
    name:
    {
      doc,
      type ? null,
      args ? [ ],
      experimental-feature ? null,
      impure-only ? false,
    }:
    let
      type' = optionalString (type != null) " (${type})";

      experimentalNotice = optionalString (experimental-feature != null) ''
        > **Note**
        >
        > This function is only available if the [`${experimental-feature}` experimental feature](@docroot@/development/experimental-features.md#xp-feature-${experimental-feature}) is enabled.
        >
        > For example, include the following in [`nix.conf`](@docroot@/command-ref/conf-file.md):
        >
        > ```
        > extra-experimental-features = ${experimental-feature}
        > ```
      '';

      impureNotice = optionalString impure-only ''
        > **Note**
        >
        > Not available in [pure evaluation mode](@docroot@/command-ref/conf-file.md#conf-pure-eval).
      '';
    in
    squash ''
      <dt id="builtins-${name}">
        <a href="#builtins-${name}"><code>${name}${listArgs args}</code></a>${type'}
      </dt>
      <dd>

      ${experimentalNotice}

      ${doc}

      ${impureNotice}
      </dd>
    '';
  listArgs = args: concatStringsSep "" (map (s: " <var>${s}</var>") args);
in
concatStringsSep "\n" (attrValues (mapAttrs showBuiltin builtinsInfo))
