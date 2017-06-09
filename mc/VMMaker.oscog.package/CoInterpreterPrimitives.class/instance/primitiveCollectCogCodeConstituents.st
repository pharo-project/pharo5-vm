process primitives
primitiveCollectCogCodeConstituents
	"Answer the contents of the code zone as an array of pair-wise element, address in ascending
	 address order. Answer a string for a runtime routine or abstract label (beginning, end, etc),
	 a CompiledMethod for a CMMethod, or a selector (presumably a Symbol) for a PIC.
	 If there is an argument and it is true, then collect inner information about the CogMethod."
	| constituents withDetails |
	argumentCount = 0
		ifTrue: [withDetails := false]
		ifFalse:
			[withDetails := self stackTop.
			 (withDetails = objectMemory trueObject
			  or: [withDetails = objectMemory falseObject]) ifFalse:
				[^self primitiveFailFor: PrimErrBadArgument].
			  withDetails := withDetails = objectMemory trueObject].
	constituents := cogit cogCodeConstituents: withDetails.
	constituents ifNil:
		[^self primitiveFailFor: PrimErrNoMemory].
	self pop: argumentCount + 1 thenPush: constituents