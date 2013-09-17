initialization
computeStackZoneSize
	^numStackPages * ((self sizeof: InterpreterStackPage) + self stackPageByteSize)
	 + stackPages extraStackBytes