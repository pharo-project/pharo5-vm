generate machine code - concretize
concretizeMoveMwrR
	<var: #offset type: #sqInt>
	| baseReg offset destReg |
	offset := operands at: 0.
	baseReg := operands at: 1.
	destReg := operands at: 2.
	(self isShortOffset: offset) ifTrue:
		[self machineCodeAt: 0 put: (self lwR: destReg base: baseReg offset: offset).
		^machineCodeSize := 4].
	
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: offset)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: offset)).
	self machineCodeAt: 8 put: (self adduR: AT R: baseReg R: AT).
	self machineCodeAt: 12 put: (self lwR: destReg base: AT offset: 0).
	^machineCodeSize := 16.
