simulation only
breakAt: address
	((breakPC isBreakpointFor: address)
	 and: [breakBlock shouldStopIfAtPC: address]) ifTrue:
		[coInterpreter changed: #byteCountText.
		 self halt: 'machine code breakpoint at ', address]