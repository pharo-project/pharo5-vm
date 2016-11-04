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
		var: #objStackInvalidBecause type: #'char *';
		var: #unscannedEphemerons type: #SpurContiguousObjStack;
		var: #heapGrowthToSizeGCRatio type: #float;
		var: #heapSizeAtPreviousGC type: #usqInt;
		var: #totalFreeOldSpace type: #usqInt;
		var: #maxOldSpaceSize type: #usqInt.
	aCCodeGenerator
		var: #remapBuffer
		declareC: 'sqInt remapBuffer[RemapBufferSize + 1 /* ', (RemapBufferSize + 1) printString, ' */]'.
	aCCodeGenerator
		var: #extraRoots
		declareC: 'sqInt *extraRoots[ExtraRootsSize + 1 /* ', (ExtraRootsSize + 1) printString, ' */]'