C code generator
emitCTestBlock: aBlockNode on: aStream indent: level
	"Emit C code for the given block node to be used as a loop test."

	(aBlockNode statements size > 1
			ifTrue: [aBlockNode]
			ifFalse: [aBlockNode statements first])
		emitCCodeAsExpressionOn: aStream level: level generator: self