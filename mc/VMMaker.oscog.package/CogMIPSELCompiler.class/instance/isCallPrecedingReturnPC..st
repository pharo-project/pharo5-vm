testing
isCallPrecedingReturnPC: mcpc
	"Assuming mcpc is a send return pc answer if the instruction before it is a call (not a CallFull)."
	"cogit disassembleFrom: mcpc - 8 to: mcpc."

	(self opcodeAtAddress: mcpc - 8) = JAL ifTrue: [^true].
	
	((self opcodeAtAddress: mcpc - 8) = SPECIAL
		and: [(self functionAtAddress: mcpc - 8) = JALR]) ifTrue: [^true].
	
	^false