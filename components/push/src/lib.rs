#![feature(question_mark)]
#[macro_use]
extern crate rustfbp;
extern crate capnp;
extern crate nanomsg;

use std::thread;
use nanomsg::{Socket, Protocol};

pub struct Portal {
    socket: Option<Socket>,
}

impl Portal {
    fn new() -> Portal {
        Portal {
            socket: None,
        }
    }
}

component! {
  push, contracts( generic_text )
  inputs(connect: generic_text, ip: any),
  inputs_array(),
  outputs(),
  outputs_array(),
  option(),
  acc(), portal(Portal => Portal::new())
  fn run(&mut self) -> Result<()> {
      if let Ok(mut ip) = self.ports.try_recv("connect") {
          let reader: generic_text::Reader = ip.get_root()?;
          let mut socket = Socket::new(Protocol::Push)
              .or(Err(result::Error::Misc("Cannot create socket".into())))?;
          socket.bind(reader.get_text()?)
              .or(Err(result::Error::Misc("Cannot connect socket".into())))?;
          self.portal.socket = Some(socket);
      }

      if let Ok(ip) = self.ports.try_recv("ip") {
          if let Some(ref mut socket) = self.portal.socket {
              socket.write(&ip.vec[..]);
          }
      }

      Ok(())
  }
}
