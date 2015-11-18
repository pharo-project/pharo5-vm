inline cacheing
relocateMethodReferenceBeforeAddress: pc by: delta
	| oldValue newValue |
	cogit disassembleFrom: pc - 8 to: pc.

	oldValue := self literalAtAddress: pc - 4.
	newValue := oldValue + delta.
	self literalAtAddress: pc - 4 put: newValue.
	
	cogit disassembleFrom: pc - 8 to: pc.
	self assert: (self literalAtAddress: pc - 4) = newValue.
	