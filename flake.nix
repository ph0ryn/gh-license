{
  description = "Create a LICENSE file from GitLab license templates";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, self, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      flake = {
        overlays.default = final: _prev: {
          gh-license = final.stdenvNoCC.mkDerivation {
            pname = "gh-license";
            version = "0.1.0";

            src = self;

            nativeBuildInputs = [
              final.makeWrapper
            ];

            dontBuild = true;

            installPhase = ''
              runHook preInstall

              install -Dm755 gh-license "$out/bin/gh-license"

              runHook postInstall
            '';

            postFixup = ''
              patchShebangs "$out/bin/gh-license"
              wrapProgram "$out/bin/gh-license" \
                --prefix PATH : ${
                  final.lib.makeBinPath [
                    final.coreutils
                    final.curl
                    final.fzf
                    final.gawk
                    final.gh
                    final.jq
                  ]
                }
            '';

            meta = {
              description = "Pick a GitLab license template with fzf and write LICENSE";
              homepage = "https://github.com/ph0ryn/gh-license";
              license = final.lib.licenses.mit;
              mainProgram = "gh-license";
              platforms = final.lib.platforms.unix;
            };
          };
        };
      };
    };
}
