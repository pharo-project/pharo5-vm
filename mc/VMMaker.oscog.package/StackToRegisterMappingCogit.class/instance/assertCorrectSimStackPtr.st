compile abstract instructions
assertCorrectSimStackPtr
	<inline: true> "generates nothing anyway"
	 self cCode: '' inSmalltalk:
		[deadCode ifFalse:
			[self assert: simStackPtr + (needsFrame ifTrue: [0] ifFalse: [1])
						= (self debugStackPointerFor: bytecodePC)]].
	