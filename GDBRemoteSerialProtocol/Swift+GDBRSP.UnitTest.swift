//
//  Swift+GDBRSP.UnitTest.swift
//  GDBRemoteSerialProtocol
//
//  Created by Hoon H. on 2015/01/20.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

extension UnitTest {
	static func testSwiftExtensions() {
		func run(f:()->()) {
			f()
		}
		
		
		
		run {
			let	v	=	0xFF as UInt8
			let	v1	=	v.toLowercaseHex()
			assert(v1.0 == U8U("f"))
			assert(v1.1 == U8U("f"))
		}
		run {
			let	v	=	0x00 as UInt8
			let	v1	=	v.toLowercaseHex()
			assert(v1.0 == U8U("0"))
			assert(v1.1 == U8U("0"))
		}
		run {
			let	v	=	0x34 as UInt8
			let	v1	=	v.toLowercaseHex()
			assert(v1.0 == U8U("3"))
			assert(v1.1 == U8U("4"))
		}
		run {
			let	v	=	0xAB as UInt8
			let	v1	=	v.toLowercaseHex()
			assert(v1.0 == U8U("a"))
			assert(v1.1 == U8U("b"))
		}
		
		
		
		run {
			let	v	=	(U8U("a"), U8U("b"))
			let	v1	=	UInt8(lowercaseHex: v)
			assert(v1 == 0xAB)
		}
		run {
			let	v	=	(U8U("3"), U8U("4"))
			let	v1	=	UInt8(lowercaseHex: v)
			assert(v1 == 0x34)
		}
		run {
			let	v	=	(U8U("0"), U8U("0"))
			let	v1	=	UInt8(lowercaseHex: v)
			assert(v1 == 0x00)
		}
		run {
			let	v	=	(U8U("f"), U8U("f"))
			let	v1	=	UInt8(lowercaseHex: v)
			assert(v1 == 0xff)
		}
	}
}




















