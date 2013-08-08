error handling
instructionTypeAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Identify which type of instruction is at pc in memoryArray. For the time beeing, only those instructions needed for PrimitiveFailure are identified."
	| RISCTempReg lastInstruction typeOperandStatus |
	RISCTempReg := CogARMCompiler classPool at: #RISCTempReg.
	lastInstruction := memoryArray unsignedLongAt: pc + 1 bigEndian: false.
	"self disassembleFrom: pc - 16 to: pc + 3 in: memoryArray on: Transcript cr"
	
	"Ret"
	lastInstruction = 16rE8BD8000 ifTrue: [#Ret].

	"Call"
	(((memoryArray byteAt: pc + 4) bitAnd: 16rF) = 16rB "BL opcode"
		or: [(memoryArray unsignedLongAt: pc - 3 bigEndian: false) = 16rE1A0E00F]) ifTrue: [^#Call].
	
	"Jump"
	((memoryArray byteAt: pc + 3) >> 4 = 16rA "B opcode, for short jumps"
		or: [(lastInstruction >> 12 bitAnd: 16r0FFFF) = 
				(16r0280F + (RISCTempReg << 4)) 	"ADD? PC, RISCTempReg, #anything, for JumpLong-Instructions"])
		ifTrue: [^#Jump].
		
	typeOperandStatus := lastInstruction >> 20 bitAnd: 16rFF.
	"MoveRMbr"
	(typeOperandStatus = 16r54 or: [typeOperandStatus = 16r5C] or: [typeOperandStatus = 16r7C])
		ifTrue: [^#MoveRMbr].
		
	"MoveRAw"
	(typeOperandStatus = 16r58 and: [(lastInstruction >> 16 bitAnd: 16rF) = RISCTempReg])
		ifTrue: [^#MoveRAw].
		
	"MoveMbrR"
	(typeOperandStatus = 16r55 or: [typeOperandStatus = 16r5D] or: [typeOperandStatus = 16r7D])
		ifTrue: [^#MoveMbrR].
		
	"MoveAwR"
	((typeOperandStatus = 16r59) and: [(lastInstruction >> 16 bitAnd: 16rF) = RISCTempReg])
		ifTrue: [^#MoveAwR].
	
	
	^#UnidentifiedInstruction