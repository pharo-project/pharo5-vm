test support
testLabelsFor: aMethod
	"self new testLabelsFor: self >> #testLabelsFor:"
	| labels stream endPC |
	labels := (BytecodeDisassembler new disassemble: aMethod) labels.
	stream := InstructionStream on: aMethod.
	endPC := aMethod endPC.
	[stream pc <= endPC] whileTrue:
		[stream interpretJump
			ifNotNil: [:dist| self assert: (labels select: [:l| stream pc + dist = l value]) size = 1]
			ifNil: [stream pc: (stream nextPc: (aMethod at: stream pc))]]