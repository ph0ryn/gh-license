# gh-license

wip

## Installation

### Using gh

```sh
gh extension install ph0ryn/gh-license
```

### Using nix

Add the overlay setting in `flake.nix`

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    gh-license = {
      url = "github:ph0ryn/gh-license";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { gh-license, ... }: {
    nixpkgs.overlays = [
      gh-license.overlays.default
    ];
  };
}
```

Then add extension in `gh` config

```nix
{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-license
    ];
  };
}
```

## Usage

wip

## Requirements

- [gh](https://cli.github.com/)
- [fzf](https://github.com/junegunn/fzf)

## License

MIT
