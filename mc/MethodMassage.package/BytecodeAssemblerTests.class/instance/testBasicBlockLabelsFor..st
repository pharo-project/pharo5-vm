test support
testBasicBlockLabelsFor: aMethod
	"self new testBasicBlockLabelsFor: self >> #testBasicBlockLabelsFor:"
	| labels stream endPC |
	labels := (BasicBlockLabellingDisassembler new disassemble: aMethod) labels.
	aMethod isQuick ifTrue:
		[^self assert: labels isEmpty].
	self assert: (labels select: [:l| aMethod initialPC = l value]) size = 1.
	aMethod embeddedBlockClosures do:
		[:closure|
		self assert: (labels select: [:l| closure startpc = l value]) size = 1].
	stream := InstructionStream on: aMethod.
	endPC := aMethod endPC.
	[stream pc <= endPC] whileTrue:
		[stream interpretJump
			ifNotNil: [:dist| self assert: (labels select: [:l| stream pc + dist = l value]) size = 1]
			ifNil: [stream pc: (stream nextPc: (aMethod at: stream pc))]]