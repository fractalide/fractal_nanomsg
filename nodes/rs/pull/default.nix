{ agent, edges, mods, pkgs }:

agent {
  src = ./.;
  edges = with edges; [ PrimText ];
  mods = with mods.rs; [ rustfbp capnp nanomsg ];
  osdeps = with pkgs; [ nanomsg ];
}
