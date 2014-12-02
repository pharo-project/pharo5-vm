object access primitives
isAppropriateForCopyObject: oop
	(objectMemory isPointersNonImm: oop) ifFalse:
		[^false].
	(objectMemory isContext: oop) ifTrue:
		[^(self isStillMarriedContext: oop) not].
	"Note there is no version in CoInterpreterPrimtiives such as
		(objectMemory isCompiledMethod: oop) ifTrue:
			[^(self methodHasCogMethod: oop) not].
	 because isPointersNonImm: excludes compiled methods and the
	 copy loop in primitiveCopyObject cannot handle compiled methods."
	^true