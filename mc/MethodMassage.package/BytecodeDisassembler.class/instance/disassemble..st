disassembly
disassemble: aMethod
	| endPC |
	method := aMethod.
	labels := Array new: aMethod size + 1 withAll: false.
	instructions := Array new: aMethod size + 1.
	instrs := InstructionStream on: aMethod.
	endPC := aMethod endPC.
	labelling := true.
	[(thePC := instrs pc) <= endPC] whileTrue:
		[instrs interpretNextInstructionFor: self].
	self label.
	labelling := false.
	instrs pc: aMethod initialPC.
	[(thePC := instrs pc) <= endPC] whileTrue:
		[instrs interpretNextInstructionFor: self].
	^AssemblerMethod
		literals: aMethod literals
		instructions: self instructionSequence
		numArgs: aMethod numArgs
		numTemps: aMethod numTemps
		frameSize: aMethod frameSize
		primitive: aMethod primitive
		flag: aMethod flag
		signFlag: aMethod signFlag
		trailer: aMethod trailer
		methodClass: aMethod methodClass
		selector: aMethod selector
		compiledMethodClass: aMethod class
	
	"BytecodeDisassembler new disassemble: BytecodeDisassembler >> #jump:if:"