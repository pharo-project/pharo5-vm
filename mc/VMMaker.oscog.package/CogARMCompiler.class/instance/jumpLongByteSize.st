accessing
jumpLongByteSize
	self flag: 'for the moment the Cogit understands only a Jump vs JumpLong distinction where JumpLong spans the 32-bit address space.  But this leads to 20-byte branches.  What we need to distingush between is variable sized jumps ("short" jumps, which is what Jump means now), fixed size jumops within the code zone and fixed size jumps within the 32-bit address space.'.
	^20