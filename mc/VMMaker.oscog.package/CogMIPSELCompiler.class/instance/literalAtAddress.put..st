inline cacheing
literalAtAddress: mcpc put: newLiteral
	| instruction |
	self assert: (self opcodeAtAddress: mcpc) = ORI.
	self assert: (self opcodeAtAddress: mcpc - 4) = LUI.
	
	instruction := (objectMemory longAt: mcpc) bitAnd: 16rFFFF000.
	instruction := instruction bitOr: (self low16BitsOf: newLiteral).
	objectMemory longAt: mcpc put: instruction.

	instruction := (objectMemory longAt: mcpc - 4) bitAnd: 16rFFFF000.
	instruction := instruction bitOr: (self high16BitsOf: newLiteral).
	objectMemory longAt: mcpc put: instruction.
	
	^newLiteral