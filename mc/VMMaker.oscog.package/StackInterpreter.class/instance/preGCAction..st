object memory support
preGCAction: gcModeArg
	"Need to write back the frame pointers unless all pages are free (as in snapshot)"
	stackPage ~= 0 ifTrue:
		[self externalWriteBackHeadFramePointers].
	(gcModeArg = GCModeFull
	 and: [objectMemory hasSpurMemoryManagerAPI]) ifTrue:
		[self flushMethodCache]