testing
tempCountForBlockStartingAt: startpc in: methodOop
	^BlockLocalTempCounter
		tempCountForBlockStartingAt: startpc
		in: (self objectForOop: methodOop)