testing
extractOffsetFromBXAt: address
"this should return the long call/jump target"
	^(objectMemory byteAt: address -4) 
		+ ((objectMemory byteAt: address - 8) << 8) 
		+ ((objectMemory byteAt: address - 12) << 16) 
		+ ((objectMemory byteAt: address - 16) << 24)