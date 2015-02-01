//
//  main.swift
//  Workbench2
//
//  Created by Hoon H. on 2015/01/19.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation




//	Test clients.



let	c	=	Client(remoteServerPort: 9999)
let	s1	=	c.queryHostInfo()
let	s2	=	c.queryHostInfo()

println(s1)
println(s2)