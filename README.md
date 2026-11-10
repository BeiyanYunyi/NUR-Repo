# NUR-Repo

A personal [NUR](https://github.com/nix-community/NUR) package repository.

| Package | Source version | Platforms |
| --- | --- | --- |
| `rime-ice` | `99662ba01e3affa6a0f009174ca530b887bac3b6` | Same as nixpkgs rime-ice |
| `qingjian` | v0.3.3 | Linux |
| `patchelf-unstable` | 0.19.2-unstable-2026-10-20 | Same as nixpkgs patchelf |
| `portop` | v0.3.0 | Linux, Darwin |
| `mihomo-oix` | alpha-oix-9910e8e | x86_64-linux (amd64-v3), aarch64-linux, aarch64-darwin |

The initial versions and hashes were migrated from nix-conf without modifying that repository.

## Usage

```sh
nix build .#portop
nix run .#mihomo-oix -- -v
# Linux
nix build .#qingjian
```

The traditional NUR entry point, `default.nix`, accepts the caller's `pkgs`:

```nix
let
  packages = import /path/to/NUR-Repo { inherit pkgs; };
in {
  environment.systemPackages = [ packages.portop packages.mihomo-oix ];
}
```

Use `overlays.default` (or `overlay.nix`) to expose the same package attributes in `pkgs`.
Use `overlays.rime-ice` to override only `rime-ice`:

```nix
nixpkgs.overlays = [ inputs.nur-repo.overlays.rime-ice ];
```

The default overlay reuses this overlay, which explicitly passes the previous scope's
`rime-ice` package to avoid resolving its own replacement through `callPackage`.

`mihomo-oix` provides `bin/mihomo`; the overlay does not replace nixpkgs' `mihomo` attribute.
Flake `packages` outputs are filtered by platform.
`patchelf-unstable` includes the pinned LOAD segment fix from nix-conf (upstream PR #672); the overlay does not replace the standard `patchelf` package.

## Modules

- `nixosModules.qingjian`: enable `services.qingjian.enable` to install the Qingjian server, settings application, Fcitx5 addon, and product data, and start the user service. Override the package with `services.qingjian.package`.
