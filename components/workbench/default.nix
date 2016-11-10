{ stdenv
  , buildFractalideSubnet
  , debug
  , io_print
  , ip_delay
  , pull
  , push
  # contracts
  , generic_text
  , ...}:

buildFractalideSubnet rec {
   src = ./.;
   subnet = ''
   '${generic_text}:(text="ipc:///tmp/pipeline.ipc")' -> connect pull(${pull})
   '${generic_text}:(text="ipc:///tmp/pipeline.ipc")' -> connect pull2(${pull})
   '${generic_text}:(text="ipc:///tmp/pipeline.ipc")' -> connect push(${push})

   '${generic_text}:(text="IP over socket")' -> ip push()
   '${generic_text}:(text="IP2 over socket")' ->
       input d1(${ip_delay}) output ->
       ip push()
    '${generic_text}:(text="IP3 over socket")' ->
      input d11(${ip_delay}) output ->
      input d12(${ip_delay}) output ->
      ip push()
   pull() ip -> input print(${io_print})

   pull2() ip -> input debug(${debug}) output -> input print2(${io_print})
   '${generic_text}:(text="On pull2")' -> option debug()
   '';

   meta = with stdenv.lib; {
    description = "Subnet: Counter app";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/development/test;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
