{ stdenv, openssl
  , buildFractalideComponent
  , genName, upkeepers
  , generic_text
# 3th party
  , nanomsg
  , ...}:

buildFractalideComponent rec {
  name = genName ./.;
  src = ./.;
  contracts = [ generic_text ];
  buildInputs = [ nanomsg ];
  depsSha256 = "04b7cp9ad671n9lbzljjwnjpipzar6phpvmgfwn6ipnq6qf90wa0";

  meta = with stdenv.lib; {
    description = "Component: net http";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/maths/boolean/nand;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
