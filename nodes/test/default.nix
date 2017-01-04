{ subgraph, nodes, edges }:

subgraph {
  src = ./.;
  flowscript = with nodes; with edges; ''
  '${prim_text}:(text="ipc:///tmp/pipeline.ipc")' -> connect pull(${pull})
  '${prim_text}:(text="ipc:///tmp/pipeline.ipc")' -> connect pull2(${pull})
  '${prim_text}:(text="ipc:///tmp/pipeline.ipc")' -> connect push(${push})

  '${prim_text}:(text="IP over socket")' -> ip push()
  '${prim_text}:(text="IP2 over socket")' ->
     input d1(${msg_delay}) output ->
     ip push()
  '${prim_text}:(text="IP3 over socket")' ->
    input d11(${msg_delay}) output ->
    input d12(${msg_delay}) output ->
    ip push()
  pull() ip -> input print(${io_print})

  pull2() ip -> input debug(${debug}) output -> input print2(${io_print})
  '${prim_text}:(text="On pull2")' -> option debug()
  '';
}
