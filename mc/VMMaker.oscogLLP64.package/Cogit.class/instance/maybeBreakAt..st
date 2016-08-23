simulation only
maybeBreakAt: address
	<doNotGenerate>
	((breakPC isBreakpointFor: address)
	 and: [breakBlock shouldStopIfAtPC: address]) ifTrue:
		[coInterpreter changed: #byteCountText.
		 self halt: 'machine code breakpoint at ', address hex, ' in ', thisContext sender selector]