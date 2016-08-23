return bytecodes
findUnwindThroughContext: homeContext
	"Search for either an unwind-protect (activation of method with primitive 198)
	 or homeContext along the sender chain, which ever is found first.  Return values:
		0			home context was found on sender chain with no intervening unwind-protects
		nilObj		home context could not be found => cannotReturn
		context		the context of an intervening unwind-protect implies home context was found"
	| onSamePage ctxtOrNilOrZero theMethod |
	"Almost always (98%) the home is on the same page, in which case we know it will be found."
	onSamePage := (self isStillMarriedContext: homeContext)
					and: [(stackPages pageIndexFor: framePointer) = (stackPages pageIndexFor: (self frameOfMarriedContext: homeContext))].

	"Since nothing changes we don't need to internalize."
	ctxtOrNilOrZero := self findMethodWithPrimitive: 198 FromFP: framePointer UpToContext: homeContext.
	self deny: (onSamePage and: [ctxtOrNilOrZero = objectMemory nilObject]).

	ctxtOrNilOrZero = 0 ifTrue:
		[theMethod := objectMemory fetchPointer: MethodIndex ofObject: homeContext.
		 (self primitiveIndexOf: theMethod) = 198 ifTrue:
			[^homeContext].
		 ^0].

	"If an unwind was found, can the home context be found also?  No need to look if on the same page.
	 No need to look if cannot return (ctxtOrNilOrZero = objectMemory nilObject)"
	(onSamePage
	 or: [ctxtOrNilOrZero = objectMemory nilObject]) ifFalse:
		[(self findMethodWithPrimitive: 0 FromContext: ctxtOrNilOrZero UpToContext: homeContext)
		  = objectMemory nilObject ifTrue:
			[^objectMemory nilObject]].
	^ctxtOrNilOrZero