{ agent, edges, crates, pkgs }:

agent {
  src = ./.;
  edges = with edges; [ generic_text ];
  crates = with crates; [ rustfbp capnp nanomsg ];
  osdeps = with pkgs; [ nanomsg ];
}
