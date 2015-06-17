compile abstract instructions
literalInstructionAt: index
	<cmacro: '(index) (&literals[index])'>
	<returnTypeC: #'AbstractInstruction *'>
	^(literals at: index)
		ifNil: [literals at: index put: (CogCompilerClass for: cogit)]
		ifNotNil: [:litInst| litInst]