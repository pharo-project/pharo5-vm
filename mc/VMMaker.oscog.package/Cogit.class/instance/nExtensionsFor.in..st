simulation only
nExtensionsFor: bcpc in: aMethodObj
	(coInterpreter methodUsesAlternateBytecodeSet: aMethodObj) ifFalse:
		[^0].
	^(InstructionStream on: (VMCompiledMethodProxy new
								for: aMethodObj
								coInterpreter: coInterpreter
								objectMemory: objectMemory))
		extensionsForBytecodeAt: bcpc + 1
		into: [:extAValue :extBValue| (extAValue ~= 0 ifTrue: [1] ifFalse: [0]) + (extBValue ~= 0 ifTrue: [1] ifFalse: [0])]