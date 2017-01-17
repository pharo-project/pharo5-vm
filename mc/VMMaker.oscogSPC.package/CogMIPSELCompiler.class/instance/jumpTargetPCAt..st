disassembly
jumpTargetPCAt: pc
	<returnTypeC: #usqInt>
	"cogit disassembleFrom: pc to: pc + 4."
	
	(self opcodeAtAddress: pc) = J ifTrue: [^self targetFromJTypeAtAddress: pc].

	(self opcodeAtAddress: pc) = BEQ ifTrue: [^self targetFromITypeAtAddress: pc].
	(self opcodeAtAddress: pc) = BNE ifTrue: [^self targetFromITypeAtAddress: pc].
	(self opcodeAtAddress: pc) = BLEZ ifTrue: [^self targetFromITypeAtAddress: pc].
	(self opcodeAtAddress: pc) = BGTZ ifTrue: [^self targetFromITypeAtAddress: pc].
	(self opcodeAtAddress: pc) = REGIMM ifTrue:
		[(self rtAtAddress: pc) = BLTZ ifTrue: [^self targetFromITypeAtAddress: pc].
		 (self rtAtAddress: pc) = BGEZ ifTrue: [^self targetFromITypeAtAddress: pc]].
	
	self unreachable.