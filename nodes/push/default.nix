{ agent, edges, crates, pkgs }:

agent {
  src = ./.;
  edges = with edges; [ generic_text ];
  crates = with crates; [];
  osdeps = with pkgs; [ nanomsg ];
  depsSha256 = "04b7cp9ad671n9lbzljjwnjpipzar6phpvmgfwn6ipnq6qf90wa0";
}
