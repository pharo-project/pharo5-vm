initialization
computeStackZoneSize
	self cCode: []
		inSmalltalk: [stackPages ifNil: [stackPages := self stackPagesClass new]].
	^numStackPages * ((self sizeof: InterpreterStackPage) + self stackPageByteSize)
	 + stackPages extraStackBytes