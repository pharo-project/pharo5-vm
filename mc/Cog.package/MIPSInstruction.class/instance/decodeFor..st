as yet unclassified
decodeFor: visitor
	| opcode |
	opcode := self opcode.
	opcode = SPECIAL ifTrue: [^self decodeSpecialFor: visitor].
	opcode = REGIMM ifTrue: [^self decodeRegImmFor: visitor].

	opcode = J ifTrue: [^visitor jump: self].
	opcode = JAL ifTrue: [^visitor jumpAndLink: self].
	opcode = BEQ ifTrue: [^visitor branchEqual: self].
	opcode = BNE ifTrue: [^visitor branchNotEqual: self].
	opcode = BLEZ ifTrue: [^visitor branchLessEqualZero: self].
	opcode = BGTZ ifTrue: [^visitor branchGreaterThanZero: self].
	opcode = ADDIU ifTrue: [^visitor addImmediateUnsigned: self].
	opcode = SLTI ifTrue: [^visitor setOnLessThanImmediate: self].
	opcode = SLTIU ifTrue: [^visitor setOnLessThanImmediateUnsigned: self].
	opcode = ANDI ifTrue: [^visitor andImmediate: self].
	opcode = ORI ifTrue: [^visitor orImmediate: self].
	opcode = XORI ifTrue: [^visitor xorImmediate: self].
	opcode = LUI ifTrue: [^visitor loadUpperImmediate: self].
	opcode = LB ifTrue: [^visitor loadByte: self].
	opcode = LH ifTrue: [^visitor loadHalfword: self].
	opcode = LW ifTrue: [^visitor loadWord: self].
	opcode = LBU ifTrue: [^visitor loadByteUnsigned: self].
	opcode = LHU ifTrue: [^visitor loadHalfwordUnsigned: self].
	opcode = SB ifTrue: [^visitor storeByte: self].
	opcode = SH ifTrue: [^visitor storeHalfword: self].
	opcode = SW ifTrue: [^visitor storeWord: self].
	opcode = PREF ifTrue: [^visitor prefetch: self].

	self error: 'Unknown instruction'.