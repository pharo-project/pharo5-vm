jump bytecodes
longUnconditionalJump
	| offset |
	offset := (((currentBytecode bitAnd: 7) - 4) * 256) + self fetchByte.
	localIP := localIP + offset.
	self ifBackwardsCheckForEvents: offset.
	self fetchNextBytecode