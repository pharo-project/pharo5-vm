inline cacheing
relocateMethodReferenceBeforeAddress: pc by: delta
	| oldValue newValue |
	"cogit disassembleFrom: pc - 16 to: pc + 16 a StackToRegisterMappingCogit."
	
	((self opcodeAtAddress: pc - 8) = ADDIU and: [(self opcodeAtAddress: pc - 4) = SW]) ifTrue:
		["PushCw"
		oldValue := self literalAtAddress: pc - 12.
		newValue := oldValue + delta.
		self literalAtAddress: pc - 12 put: newValue.	
		self assert: (self literalAtAddress: pc - 12) = newValue.
		^self].

	"MoveCwR"
	oldValue := self literalAtAddress: pc - 4.
	newValue := oldValue + delta.
	self literalAtAddress: pc - 4 put: newValue.
	
	"cogit disassembleFrom: pc - 8 to: pc."
	self assert: (self literalAtAddress: pc - 4) = newValue.
	