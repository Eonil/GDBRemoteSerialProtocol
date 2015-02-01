//
//  Swift+GCDRSP.swift
//  GDBRemoteSerialProtocol
//
//  Created by Hoon H. on 2015/01/20.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation












extension UInt8 {
	init(lowercaseHex: SingleByteHex) {
		func fromASCIIChar(u:U8U) -> UInt8 {
			return	u < U8U("a") ? u - U8U("0") : u - U8U("a") + 10
		}
		
		let	a	=	fromASCIIChar(lowercaseHex.0) << 4
		let	b	=	fromASCIIChar(lowercaseHex.1)
		
		self	=	a + b
	}
	func toLowercaseHex() -> SingleByteHex {
		func toASCIIChar(u:UInt8) -> U8U {
			return	u > 9 ? u - 10 + U8U("a") : u + U8U("0")
		}
		
		let	a	=	(UInt8(0xF0) & self) >> 4
		let	b	=	UInt8(0x0F) & self
		
		return	SingleByteHex(toASCIIChar(a), toASCIIChar(b))
	}
}














extension String {
	init?(UTF8CodeUnits: [U8U]?) {
		if UTF8CodeUnits == nil {
			return	nil
		}
		
		////
		
		self	=	""
		
		var	de	=	UTF8()
		var	g	=	UTF8CodeUnits!.generate()
		
		var	c	=	true
		while c {
			switch de.decode(&g) {
			case .Error:
				return	nil
				
			case .EmptyInput:
				c	=	false
				
			case .Result(let s):
				self.append(s)
			}
		}
	}
}








