//
//  Client.swift
//  EditorDebuggingFeature
//
//  Created by Hoon H. on 2015/01/19.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

class Client {
	init(remoteServerPort:UInt16) {
		channel	=	Channel(address: TCPIPSocketAddress.localhost, port: remoteServerPort)
		
		channel.delegate	=	self
	}
	deinit {
	}
	func sendInterrupt() {
		let	CODE	=	UInt8(0x03)
	}
	func sendPacket(p:Packet) {
		var	again	=	true
		while again {
			var	bs	=	p.snapshot()
			channel.write(bs)
			again	=	receiveACK() == false
		}
	}
	
	///	Returns `nil` for any error.
	func receivePacket() -> Packet? {
		var	again	=	true
		while again {
			var	p	=	PacketParser()
			while p.done() == false {
				let	b	=	channel.read()
				p.push(b, allowReset: false)
			}
			
			let	r	=	p.produce()
			if let r1 = r {
				sendACK(true)
				again	=	false
				return	r1
			} else {
				sendACK(false)
			}
		}
//		return	nil
	}
	
	////
	
	private let	channel:Channel
	private func receiveACK() -> Bool {
		let	b	=	channel.read()
		return	b == U8U("+") ? true : false
	}
	private func sendACK(ok:Bool) {
		let	b	=	ok ? U8U("+") : U8U("-")
		channel.write([b])
	}
}
extension Client: ChannelDelegate {
	func channelWillSendData(data: [UInt8]) {
		print(String(UTF8CodeUnits: data)!)
	}
	func channelDidReceiveData(data: [UInt8]) {
		print(String(UTF8CodeUnits: data)!)
	}
}




protocol ChannelDelegate: class {
	func channelWillSendData([UInt8])
	func channelDidReceiveData([UInt8])
}
final class Channel {
	weak var delegate:ChannelDelegate?
	
	init(address:TCPIPSocketAddress, port:UInt16) {
		socket	=	TCPIPSocket()
		file	=	NSFileHandle(fileDescriptor: socket.socketDescriptor, closeOnDealloc: false)
		
		socket.connect(address, port)
	}
	func write(data:[UInt8]) {
		delegate?.channelWillSendData(data)
		var	bs	=	data
		bs.withUnsafeMutableBufferPointer { [unowned self](inout bp:UnsafeMutableBufferPointer<UInt8>) -> () in
			let	d1	=	NSData(bytesNoCopy: bp.baseAddress, length: bp.count, freeWhenDone: false)
			self.file.writeData(d1)
		}
	}
	func read() -> UInt8 {
		let	d	=	file.readDataOfLength(1)
		let	m	=	unsafePointerCast(d.bytes) as UnsafePointer<UInt8>
		let	b	=	m.memory
//		print(String(UTF8CodeUnits: [U8U(b)])!)
		delegate?.channelDidReceiveData([b])
		return	b
	}
	
	private let	socket	:	TCPIPSocket
	private let	file	:	NSFileHandle
}









extension Client {
	func queryHostInfo() -> String? {
		return	String(UTF8CodeUnits: query("qHostInfo"))
	}
	func GDBServerVersion() -> String? {
		return	String(UTF8CodeUnits: query("qGDBServerVersion"))
	}
	
	////
	
	func query(command:String) -> [UInt8]? {
		let	p	=	Packet(string: command)
		sendPacket(p)
		print("\n")
		
		if let p1 = receivePacket() {
			print("\n----\n")
			return	p1.data
		}
		assert(false, "query failure: \(command)")
		return	nil
	}
}









