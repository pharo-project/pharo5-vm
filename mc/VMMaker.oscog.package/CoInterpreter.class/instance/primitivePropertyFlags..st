cog jit support
primitivePropertyFlags: primIndex
	<api>
	"Answer any special requirements of the given primitive"
	objectMemory hasSpurMemoryManagerAPI
		ifTrue: [^self primitivePropertyFlagsForSpur: primIndex]
		ifFalse: [^self primitivePropertyFlagsForV3: primIndex]