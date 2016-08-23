cog jit support
allocatePinnedSlots: nSlots
	^(objectMemory allocatePinnedSlots: nSlots)
		ifNil: [nil]
		ifNotNil:
			[:objOop |
			 objectMap at: objOop put: objOop]