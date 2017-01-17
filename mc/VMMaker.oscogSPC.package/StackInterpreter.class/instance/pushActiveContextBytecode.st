stack bytecodes
pushActiveContextBytecode
	| ourContext |
	ourContext := self ensureFrameIsMarried: localFP SP: localSP.
	self fetchNextBytecode.
	self internalPush: ourContext