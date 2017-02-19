#![feature(question_mark)]
#[macro_use]
extern crate rustfbp;
extern crate capnp;
extern crate nanomsg;

use std::thread;
use nanomsg::{Socket, Protocol};

pub struct State {
    socket: Option<Socket>,
}

impl State {
    fn new() -> State {
        State {
            socket: None,
        }
    }
}

agent! {
  input(connect: prim_text, ip: any),
  state(State => State::new()),
  fn run(&mut self) -> Result<Signal> {
      if let Ok(mut ip) = self.input.connect.try_recv() {
          let reader: prim_text::Reader = ip.read_schema()?;
          let mut socket = Socket::new(Protocol::Push)
              .or(Err(result::Error::Misc("Cannot create socket".into())))?;
          socket.bind(reader.get_text()?)
              .or(Err(result::Error::Misc("Cannot connect socket".into())))?;
          self.state.socket = Some(socket);
      }

      if let Ok(ip) = self.input.ip.try_recv() {
          if let Some(ref mut socket) = self.state.socket {
              socket.write(&ip.vec[..]);
          }
      }

      Ok(())
  }
}
