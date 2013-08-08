initialization
computeStackZoneSize
	^numStackPages * ((self sizeof: CogStackPage) + self stackPageByteSize)
	 + stackPages extraStackBytes