debugging traps
primitiveNewWithArg
	"(objectMemory hasSpurMemoryManagerAPI
	 and: [self classNameOf: (self stackValue: 1) Is: 'MethodDictionary']) ifTrue:
		[self halt]."
	^super primitiveNewWithArg