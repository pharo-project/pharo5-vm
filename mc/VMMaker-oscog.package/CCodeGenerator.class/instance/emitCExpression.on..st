C code generator
emitCExpression: aParseNode on: aStream 
	"Emit C code for the expression described by the given parse node."

	aParseNode isLeaf 
		ifTrue: 
			["omit parens"
			 aParseNode emitCCodeAsExpressionOn: aStream level: 0 generator: self]
		ifFalse: 
			[aStream nextPut: $(.
			 aParseNode emitCCodeAsExpressionOn: aStream level: 0 generator: self.
			 aStream nextPut: $)]