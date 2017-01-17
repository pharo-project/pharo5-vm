abi
cFloatResultToRd: reg
	XMM0L ~= reg ifTrue: [ 
		cogit MoveRd: XMM0L Rd: reg
	].