#![feature(question_mark)]
#[macro_use]
extern crate rustfbp;
extern crate capnp;
extern crate nanomsg;

use std::thread;
use nanomsg::{Socket, Protocol};

agent! {
  input(connect: prim_text, packet: any),
  output(ip: any),
  fn run(&mut self) -> Result<Signal> {
      if let Ok(mut ip) = self.input.connect.try_recv() {
          let reader: prim_text::Reader = ip.read_schema()?;
          let mut socket = Socket::new(Protocol::Pull)
              .or(Err(result::Error::Misc("Cannot create socket".into())))?;
          socket.connect(reader.get_text()?)
              .or(Err(result::Error::Misc("Cannot bind socket".into())))?;
          let sender = self.input.packet.get_sender();
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

      if let Ok(ip) = self.input.packet.try_recv() {
          self.output.ip.send(ip)?;
      }
      Ok(End)
  }
}
