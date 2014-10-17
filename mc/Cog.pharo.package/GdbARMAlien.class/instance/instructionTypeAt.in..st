error handling
instructionTypeAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Identify which type of instruction is at pc in memoryArray. For the time being, only those instructions needed for PrimitiveFailure are identified."
	| RISCTempReg lastInstruction typeOperandStatus |
	RISCTempReg := CogARMCompiler ARMTempReg.
	lastInstruction := memoryArray unsignedLongAt:  pc + 1 bigEndian: false .
	"self disassembleFrom: pc - 16 to: pc + 11 in: memoryArray on: Transcript cr"
	
	"Ret"
	(self instructionIsReturnViaLR: lastInstruction ) ifTrue: [^#Ret].

	"Call"
	(self instructionIsBL: lastInstruction) ifTrue: [^#Call].
	"long call"
	(self instructionIsBLX: lastInstruction) ifTrue: [^#LongCall].
	
	
	"Jump"
	(self instructionIsB: lastInstruction) ifTrue: [^#Jump].
	"long Jump"
	(self instructionIsBX: lastInstruction) ifTrue: [^#LongJump].
		
	typeOperandStatus := lastInstruction >> 20 bitAnd: 16rFF.
	"MoveRMbr"
	(self instructionIsSTRB: lastInstruction) ifTrue: [^#MoveRMbr].
		
	"MoveRAw"
	(self instructionIsSTR: lastInstruction byReg: RISCTempReg) ifTrue: [^#MoveRAw].
		
	"MoveMbrR"
	(self instructionIsLDRB: lastInstruction) ifTrue: [^#MoveMbrR].
		
	"MoveAwR"
	(self instructionIsLDR: lastInstruction byReg: RISCTempReg) ifTrue: [^#MoveAwR].
	
	
	^#UnidentifiedInstruction