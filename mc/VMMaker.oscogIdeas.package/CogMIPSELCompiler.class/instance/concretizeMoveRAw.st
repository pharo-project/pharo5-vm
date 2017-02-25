generate machine code - concretize
concretizeMoveRAw
	| srcReg destAddr |
	srcReg := operands at: 0.
	destAddr := operands at: 1.

	(self isAddressRelativeToVarBase: destAddr) ifTrue:
		[self machineCodeAt: 0 put: (self swR: srcReg base: ConcreteVarBaseReg offset: destAddr - cogit varBaseAddress).
		 ^machineCodeSize := 4].

	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: destAddr)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: destAddr)).
	self machineCodeAt: 8 put: (self swR: srcReg base: AT offset: 0).
	^machineCodeSize := 12