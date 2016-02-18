generate machine code - concretize
concretizeSubCwR
	| destReg leftReg rightImm |
	rightImm := operands at: 0.
	destReg := leftReg := operands at: 1.
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: rightImm)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: rightImm)).
	self machineCodeAt: 8 put: (self subuR: destReg R: leftReg R: AT).
	^machineCodeSize := 12