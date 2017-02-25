bytecode generators
genSpecialSelectorClass
	| topReg destReg scratchReg |
	topReg := self allocateRegForStackEntryAt: 0.
	destReg := self allocateRegNotConflictingWith: (self registerMaskFor: topReg).
	scratchReg := self allocateRegNotConflictingWith: (self registerMaskFor: topReg and: destReg).
	self ssTop popToReg: topReg.
	self asserta: (objectRepresentation
					genGetClassObjectOf: topReg
					into: destReg
					scratchReg: scratchReg
					instRegIsReceiver: false) ~= BadRegisterSet.
	self ssPop: 1; ssPushRegister: destReg.
	^0