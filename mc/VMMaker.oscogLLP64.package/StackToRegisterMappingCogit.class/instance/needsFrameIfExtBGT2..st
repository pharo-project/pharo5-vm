compile abstract instructions
needsFrameIfExtBGT2: stackDelta
	^extB < 0 or: [extB > 2]