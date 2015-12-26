generate machine code - concretize
concretizeLoadEffectiveAddressMwrR
	<var: #offset type: #sqInt>
	| baseReg offset destReg |
	offset := operands at: 0.
	baseReg := operands at: 1.
	destReg := operands at: 2.
	(self isShortOffset: offset) ifTrue:
		[self machineCodeAt: 0 put: (self addiuR: destReg R: baseReg C: offset).
		^machineCodeSize := 4].
	
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: offset)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: offset)).
	self machineCodeAt: 8 put: (self adduR: destReg R: baseReg R: AT).
	^machineCodeSize := 12.
