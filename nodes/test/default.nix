{ subgraph, imsg, nodes, edges }:
let
  PrimText1 = imsg { class = edges.PrimText; text = ''(text="ipc:///tmp/pipeline.ipc")''; };
  PrimText2 = imsg { class = edges.PrimText; text = ''(text="IP over socket")''; };
  PrimText3 = imsg { class = edges.PrimText; text = ''(text="IP2 over socket")''; };
  PrimText4 = imsg { class = edges.PrimText; text = ''(text="IP3 over socket")''; };
  PrimText5 = imsg { class = edges.PrimText; text = ''(text="On pull2")''; };
in
subgraph {
  src = ./.;
  flowscript = with nodes; ''
  '${PrimText1}' -> connect pull(${pull})
  '${PrimText1}' -> connect pull2(${pull})
  '${PrimText1}' -> connect push(${push})

  '${PrimText2}' -> ip push()
  '${PrimText3}' -> input d1(${msg_delay}) output -> ip push()
  '${PrimText4}' ->
    input d11(${msg_delay}) output ->
    input d12(${msg_delay}) output ->
    ip push()
  pull() ip -> input print(${io_print})

  pull2() ip -> input debug(${debug}) output -> input print2(${io_print})
  '${PrimText5}' -> option debug()
  '';
}
