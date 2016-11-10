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
  depsSha256 = "0c1r9890bnshs1s79k95lx2ylqkab315hvyahwm3k88bazl2r0cz";

  meta = with stdenv.lib; {
    description = "Component: net http";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/maths/boolean/nand;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
