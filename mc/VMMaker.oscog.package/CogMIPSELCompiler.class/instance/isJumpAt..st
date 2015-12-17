testing
isJumpAt: pc
	"cogit disassembleFrom: pc to: pc + 4."

	(self opcodeAtAddress: pc) = J ifTrue: [^true].
	
	(self opcodeAtAddress: pc) = SPECIAL ifTrue: 
		[(self functionAtAddress: pc) = JR ifTrue: [^true]].

	(self opcodeAtAddress: pc) = BEQ ifTrue: [^true].
	(self opcodeAtAddress: pc) = BNE ifTrue: [^true].
	(self opcodeAtAddress: pc) = BLEZ ifTrue: [^true].
	(self opcodeAtAddress: pc) = BGTZ ifTrue: [^true].

	(self opcodeAtAddress: pc) = REGIMM ifTrue: 
		[(self rtAtAddress: pc) = BLTZ ifTrue: [^true].
		 (self rtAtAddress: pc) = BGEZ ifTrue: [^true]].	
	
	^false