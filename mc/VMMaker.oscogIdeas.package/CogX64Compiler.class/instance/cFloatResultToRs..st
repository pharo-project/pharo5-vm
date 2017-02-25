abi
cFloatResultToRs: reg
	XMM0L ~= reg ifTrue: [ 
		cogit MoveRs: XMM0L Rs: reg
	].