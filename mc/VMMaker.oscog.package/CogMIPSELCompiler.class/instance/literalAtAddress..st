inline cacheing
literalAtAddress: mcpc
	<var: #high type: #usqInt>
	<var: #low type: #usqInt>
	| high low |
	self assert: (self opcodeAtAddress: mcpc) = ORI.
	self assert: (self opcodeAtAddress: mcpc - 4) = LUI.
	low := (objectMemory longAt: mcpc) bitAnd: 16rFFFF.
	high := (objectMemory longAt: mcpc - 4) bitAnd: 16rFFFF.
	^high << 16 bitOr: low
