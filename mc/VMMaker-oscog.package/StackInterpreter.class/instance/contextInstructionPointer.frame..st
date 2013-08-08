frame access
contextInstructionPointer: theIP frame: theFP
	<var: #theFP type: #'char *'>
	self assert: (self validInstructionPointer: theIP inFrame: theFP).
	^objectMemory integerObjectOf: theIP - (self iframeMethod: theFP) - BaseHeaderSize + 2