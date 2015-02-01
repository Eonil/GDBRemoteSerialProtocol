//
//  main.swift
//  Workbench3
//
//  Created by Hoon H. on 2015/01/20.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation


//	Develop server/client interactions.

func runClient() {
	
	dispatch_async(dispatch_get_main_queue()) {
		let	c	=	Client(remoteServerPort: 9999)
		
		func q(command:String) {
			c.query(command)
			fflush(stdout)
			fflush(stderr)
		}
		
		q("help")
		q("qC")
		q("qfThreadInfo")
//		c.queryHostInfo()
		q("exit")
	}
}










let	SAMPLE_PATH			=	"./SampleProgram1"

let	DEBUG_SERVER_PATH	=	"/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Resources/debugserver"
let	ARGUMENTS			=	["localhost:9999", SAMPLE_PATH]
let	PORT				=	9999

let	t	=	NSTask()

t.launchPath	=	DEBUG_SERVER_PATH
t.arguments		=	ARGUMENTS
t.launch()
sleep(1)
runClient()
//sleep(4)
//kill(t.processIdentifier, SIGTERM)
t.waitUntilExit()

fflush(stdout)
fflush(stderr)





