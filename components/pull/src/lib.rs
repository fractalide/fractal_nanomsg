#![feature(question_mark)]
#[macro_use]
extern crate rustfbp;
extern crate capnp;
extern crate nanomsg;

use std::thread;
use nanomsg::{Socket, Protocol};

component! {
  pull, contracts( generic_text )
  inputs(connect: generic_text, packet: any),
  inputs_array(),
  outputs(ip: any),
  outputs_array(),
  option(),
  acc(),
  fn run(&mut self) -> Result<()> {
      if let Ok(mut ip) = self.ports.try_recv("connect") {
          let reader: generic_text::Reader = ip.get_root()?;
          let mut socket = Socket::new(Protocol::Pull)
              .or(Err(result::Error::Misc("Cannot create socket".into())))?;
          socket.connect(reader.get_text()?)
              .or(Err(result::Error::Misc("Cannot bind socket".into())))?;
          let sender = self.ports.get_sender("packet")?;
          thread::spawn(move ||{
              loop {
                  let mut vec = Vec::new();
                  socket.read_to_end(&mut vec).expect("cannot read to end");
                  let mut ip = IP::new();
                  ip.vec = vec;
                  sender.send(ip).expect("cannot send outside");
              }
          });
      }

      if let Ok(ip) = self.ports.try_recv("packet") {
          self.ports.send("ip", ip)?;
      }
      Ok(())
  }
}
