{ agent, edges, crates, pkgs }:

agent {
  src = ./.;
  edges = with edges; [ PrimText ];
  crates = with crates; [ rustfbp capnp nanomsg ];
  osdeps = with pkgs; [ nanomsg ];
}
