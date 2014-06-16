translation
declareCVarsIn: aCCodeGenerator
	self declareCAsOop: #(	memory freeStart scavengeThreshold newSpaceStart newSpaceLimit pastSpaceStart
							lowSpaceThreshold freeOldSpaceStart oldSpaceStart endOfMemory firstFreeChunk lastFreeChunk)
		in: aCCodeGenerator.
	self declareCAsUSqLong: (self allInstVarNames select: [:ivn| ivn endsWith: 'Usecs'])
		in: aCCodeGenerator.
	aCCodeGenerator
		var: #freeListsMask type: #usqInt;
		var: #freeLists type: #'sqInt *';
		var: #classTableBitmap type: #'unsigned char *';
		var: #objStackInvalidBecause type: #'char *';
		var: #highestObjects type: #SpurCircularBuffer;
		var: #unscannedEphemerons type: #SpurContiguousObjStack;
		var: #heapGrowthToSizeGCRatio type: #float;
		var: #heapSizeAtPreviousGC type: #usqInt.
	aCCodeGenerator
		var: #remapBuffer
		declareC: 'sqInt remapBuffer[RemapBufferSize + 1 /* ', (RemapBufferSize + 1) printString, ' */]'.
	aCCodeGenerator
		var: #extraRoots
		declareC: 'sqInt *extraRoots[ExtraRootsSize + 1 /* ', (ExtraRootsSize + 1) printString, ' */]'