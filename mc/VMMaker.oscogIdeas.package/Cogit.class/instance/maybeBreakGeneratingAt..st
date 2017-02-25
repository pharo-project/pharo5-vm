simulation only
maybeBreakGeneratingAt: address
	"Variation on maybeBreakAt: that only works for integer breakPCs,
	 so we can have break blocks that stop at any pc, except when generating."
	<cmacro: '(address) 0'> "Simulation only; void in C"
	(breakPC = address
	 and: [breakBlock shouldStopIfAtPC: address]) ifTrue:
		[coInterpreter changed: #byteCountText.
		 self halt: 'machine code generation at ', address hex, ' in ', thisContext sender selector]