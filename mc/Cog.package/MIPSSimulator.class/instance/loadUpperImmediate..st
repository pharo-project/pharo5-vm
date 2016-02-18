instructions - arithmetic
loadUpperImmediate: instruction
	| result |
	self assert: instruction rs = 0.
	result := instruction signedImmediate << 16.
	self signedRegister: instruction rt put: result.