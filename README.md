# gh-license

`gh` extension that creates `LICENSE` files using the [GitLab Licenses API](https://docs.gitlab.com/api/templates/licenses/).

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

Pick a license with `fzf` and write it to `LICENSE`.

```sh
gh license
```

Or pass a license key directly as an argument.

```sh
gh license MIT
```

By default, `gh license` exits without writing when `LICENSE` already exists.
Use `--force` or `-f` to overwrite it.

```sh
gh license --force MIT
```

Write to a different file name in the current directory with `--output` or `-o`.

```sh
gh license --output LICENSE.md MIT
```

Print the generated license without writing `LICENSE` with `--dry-run` or `-d`.
Dry run mode cannot be combined with `--force` or `--output`.

```sh
gh license --dry-run MIT
```

This extension uses the GitLab license template API because it supports
template generation with a user name.

## Requirements

- [gh](https://cli.github.com/)
- [curl](https://curl.se/)
- [fzf](https://github.com/junegunn/fzf)
- [awk](https://pubs.opengroup.org/onlinepubs/9799919799/utilities/awk.html)
- [jq](https://jqlang.org/)

## License

MIT
