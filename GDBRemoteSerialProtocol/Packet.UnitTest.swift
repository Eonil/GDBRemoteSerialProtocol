//
//  Packet.UnitTest.swift
//  EditorDebuggingFeature
//
//  Created by Hoon H. on 2015/01/19.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

extension UnitTest {
	static func testPacketAlgorithms() {
		test1()
	}
	
	private static func test1() {
		func run(f:()->()) {
			f()
		}
		
		run {
			let	bs	=	[UInt8]("abc".utf8)
			let	bs1	=	escapeDataForPacket(bs)
			assert(bs == bs1)
		}
		run {
			let	bs	=	[UInt8]("$#*}".utf8)
			let	bs1	=	escapeDataForPacket(bs)
			assert(bs1 == [U8U("}"), 0x04, U8U("}"), 0x03, U8U("}"), 0x0A, U8U("}"), 0x5D] as [UInt8])
		}
		run {
			let	bs	=	[U8U("}"), 0x04, U8U("}"), 0x03, U8U("}"), 0x0A, U8U("}"), 0x5D] as [UInt8]
			let	bs1	=	unescapePacketData(bs)
			let	s	=	String(UTF8CodeUnits: bs1)
			assert(s == "$#*}")
		}
		run {
			let	v1	=	[U8U("A"), U8U("*"), 3 + 29]
			let	v2	=	RunLengthEncoding.decode(v1)
			let	v3	=	String(UTF8CodeUnits: v2)
			assert(v3 == "AAAA")
		}
		run {
			let	v1	=	[U8U("A"), U8U("*"), 5 + 29, U8U("B")]
			let	v2	=	RunLengthEncoding.decode(v1)
			let	v3	=	String(UTF8CodeUnits: v2)
			assert(v3 == "AAAAAAB")
		}
	}
}
















