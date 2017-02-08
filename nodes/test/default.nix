{ subgraph, imsgs, nodes, edges }:

subgraph rec {
  src = ./.;
  imsg = imsgs {
    edges = with edges; [ PrimText ];
  };
  flowscript = with nodes; ''
  '${imsg}.PrimText:(text="ipc:///tmp/pipeline.ipc")' -> connect pull(${pull})
  '${imsg}.PrimText:(text="ipc:///tmp/pipeline.ipc")' -> connect pull2(${pull})
  '${imsg}.PrimText:(text="ipc:///tmp/pipeline.ipc")' -> connect push(${push})

  '${imsg}.PrimText:(text="IP over socket")' -> ip push()
  '${imsg}.PrimText:(text="IP2 over socket")' ->
     input d1(${msg_delay}) output ->
     ip push()
  '${imsg}.PrimText:(text="IP3 over socket")' ->
    input d11(${msg_delay}) output ->
    input d12(${msg_delay}) output ->
    ip push()
  pull() ip -> input print(${io_print})

  pull2() ip -> input debug(${debug}) output -> input print2(${io_print})
  '${imsg}.PrimText:(text="On pull2")' -> option debug()
  '';
}
