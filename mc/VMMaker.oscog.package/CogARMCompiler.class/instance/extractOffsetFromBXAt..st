testing
extractOffsetFromBXAt: addr
"this should return the long call/jump target"
	^(objectMemory byteAt: addr -4) 
		+ ((objectMemory byteAt: addr - 8) << 8) 
		+ ((objectMemory byteAt: addr - 12) << 16) 
		+ ((objectMemory byteAt: addr - 16) << 24)