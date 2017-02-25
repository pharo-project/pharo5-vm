bytecode generator support
assignToTempRegConflictingRegisterIn: conflictingRegisterMask
	"Find the stackEntry in simStack whose liveRegister matches conflictingRegisterMask
	 and assign it to TempReg."
	self assert: (self isAPowerOfTwo: conflictingRegisterMask).
	0 to: simStackPtr do:
		[:i|
		 (self simStackAt: i) registerMaskOrNone = conflictingRegisterMask ifTrue:
			[(self simStackAt: i)
				storeToReg: TempReg;
				liveRegister: TempReg.
			 i+1 to: simStackPtr do:
				[:j|
				self deny: (self simStackAt: i) registerMaskOrNone = conflictingRegisterMask].
			 ^self]].
	self error: 'conflict entry not found'