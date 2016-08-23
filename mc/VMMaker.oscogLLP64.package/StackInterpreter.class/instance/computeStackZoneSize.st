initialization
computeStackZoneSize
	self cCode: [] inSmalltalk:
		[stackPages ifNil:
			[stackPages := self stackPagesClass new setInterpreter: self]].
	^numStackPages * ((self sizeof: CogStackPage) + self stackPageByteSize)
	 + stackPages extraStackBytes