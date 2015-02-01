//
//  main.swift
//  Workbench1
//
//  Created by Hoon H. on 2015/01/19.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation




//	Test sockets.



let	s	=	TCPIPSocket()
let	f	=	NSFileHandle(fileDescriptor: s.socketDescriptor)
s.connect(TCPIPSocketAddress.localhost, 9999)



let	p	=	Packet(string: "R00")
var	d	=	p.snapshot()
d.withUnsafeMutableBufferPointer { (inout bp:UnsafeMutableBufferPointer<UInt8>) -> () in
	let	d1	=	NSData(bytesNoCopy: bp.baseAddress, length: bp.count, freeWhenDone: false)
	f.writeData(d1)
}
let	a	=	NSString(data: f.readDataOfLength(4), encoding: NSUTF8StringEncoding)!
println(a)

sleep(3)
