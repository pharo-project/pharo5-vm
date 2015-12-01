testing
isCallPrecedingReturnPC: mcpc
	cogit disassembleFrom: mcpc - 8 to: mcpc.

	(self opcodeAtAddress: mcpc - 8) = JAL ifTrue: [^true].
	
	((self opcodeAtAddress: mcpc - 8) = SPECIAL
		and: [(self opcodeAtAddress: mcpc - 8) = JALR]) ifTrue: [^true].
	
	^false