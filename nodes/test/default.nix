{ subgraph, nodes, edges }:

subgraph {
  src = ./.;
  edges = with edges; [ generic_text ];
  flowscript = with nodes; with edges; ''
  '${generic_text}:(text="ipc:///tmp/pipeline.ipc")' -> connect pull(${pull})
  '${generic_text}:(text="ipc:///tmp/pipeline.ipc")' -> connect pull2(${pull})
  '${generic_text}:(text="ipc:///tmp/pipeline.ipc")' -> connect push(${push})

  '${generic_text}:(text="IP over socket")' -> ip push()
  '${generic_text}:(text="IP2 over socket")' ->
     input d1(${msg_delay}) output ->
     ip push()
  '${generic_text}:(text="IP3 over socket")' ->
    input d11(${msg_delay}) output ->
    input d12(${msg_delay}) output ->
    ip push()
  pull() ip -> input print(${io_print})

  pull2() ip -> input debug(${debug}) output -> input print2(${io_print})
  '${generic_text}:(text="On pull2")' -> option debug()
  '';
}
