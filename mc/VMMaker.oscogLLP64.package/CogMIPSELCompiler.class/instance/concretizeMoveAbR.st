generate machine code - concretize
concretizeMoveAbR
	| srcAddr destReg |
	srcAddr := operands at: 0.
	destReg := operands at: 1.

	(self isAddressRelativeToVarBase: srcAddr) ifTrue:
		[self machineCodeAt: 0 put: (self lwR: destReg base: ConcreteVarBaseReg offset: srcAddr - cogit varBaseAddress).
		 ^machineCodeSize := 4].

	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: srcAddr)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: srcAddr)).
	self machineCodeAt: 8 put: (self lbuR: destReg base: AT offset: 0).
	^machineCodeSize := 12