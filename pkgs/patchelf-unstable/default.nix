{
  lib,
  patchelf,
  fetchFromGitHub,
  autoreconfHook,
}:
let
  source = lib.importJSON ./source.json;
in
patchelf.overrideAttrs (old: {
  version = "0.19.2-unstable-2026-10-20";
  # LOAD segment fix: https://github.com/NixOS/patchelf/pull/672
  src = fetchFromGitHub {
    inherit (source) owner repo rev;
    hash = source.narHash;
  };
  nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ autoreconfHook ];
})
