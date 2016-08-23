debugging traps
primitiveNewWithArg
	"(objectMemory hasSpurMemoryManagerAPI
	 and: [self classNameOf: (self stackValue: 1) Is: 'Bitmap']) ifTrue:
		[self printExternalHeadFrame.
		 self halt]."
	^super primitiveNewWithArg