C code generator
emitCExpression: aParseNode on: aStream indent: level
	"Emit C code for the expression described by the given parse node."

	(aParseNode isLeaf
	 or: [aParseNode isSend
		 and: [#(bytesPerOop bytesPerWord baseHeaderSize wordSize) includes: aParseNode selector]])
		ifTrue: 
			["omit parens"
			 aParseNode emitCCodeAsExpressionOn: aStream level: level generator: self]
		ifFalse: 
			[aStream nextPut: $(.
			 aParseNode emitCCodeAsExpressionOn: aStream level: level generator: self.
			 aStream nextPut: $)]