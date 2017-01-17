inline cacheing
literalAtAddress: mcpc put: newLiteral
	<var: #oldUpper type: #usqInt>
	<var: #newUpper type: #usqInt>
	<var: #oldLower type: #usqInt>
	<var: #newLower type: #usqInt>
	| oldUpper newUpper oldLower newLower |
	self assert: (self opcodeAtAddress: mcpc - 4) = LUI.
	self assert: (self opcodeAtAddress: mcpc) = ORI.
	
	oldUpper := objectMemory longAt: mcpc - 4.
	newUpper := (oldUpper bitAnd: 16rFFFF0000) bitOr: (self high16BitsOf: newLiteral).
	objectMemory longAt: mcpc - 4 put: newUpper.
	
	oldLower := objectMemory longAt: mcpc.
	newLower := (oldLower bitAnd: 16rFFFF0000) bitOr: (self low16BitsOf: newLiteral).
	objectMemory longAt: mcpc put: newLower.
	
	self assert: (self opcodeAtAddress: mcpc - 4) = LUI.
	self assert: (self opcodeAtAddress: mcpc) = ORI.
	
	self assert: (self literalAtAddress: mcpc) = newLiteral.
	
	^newLiteral