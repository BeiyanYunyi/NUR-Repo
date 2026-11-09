# Repository instructions

## Documentation

All repository documentation, including README.md and this file, must be written in English.

## Package maintenance

Source revisions and NAR hashes for `rime-ice`, `qingjian`, `portop`, and `patchelf-unstable` are stored in their respective `pkgs/<name>/source.json` files.
Update both the revision and hash when upgrading a package.
For portop, also check `version` and `vendorHash`.
Qingjian fetches its source with `pkgs.fetchgit`; update `version`, the bundled `Cargo.lock` and `data.lock`, and the Cargo Git dependency hashes together.

mihomo-oix has a manifest of binary hashes for each platform and an update script:

```sh
./pkgs/mihomo-oix/update.sh [revision]
```

The script verifies that the rolling release has a consistent version across all platforms before updating `versions.json`.
