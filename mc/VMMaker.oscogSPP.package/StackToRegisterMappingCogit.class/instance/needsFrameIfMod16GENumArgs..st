compile abstract instructions
needsFrameIfMod16GENumArgs: stackDelta
	^byte0 \\ 16 >= methodOrBlockNumArgs