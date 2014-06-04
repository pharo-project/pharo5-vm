debug support
validInstructionPointer: anInstrPointer inFrame: fp
	<var: #anInstrPointer type: #usqInt>
	<var: #fp type: #'char *'>
	<inline: false>
	^self validInstructionPointer: anInstrPointer inMethod: (self frameMethodObject: fp) framePointer: fp