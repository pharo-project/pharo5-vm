indexing primitives
primitiveContextAt
	"Special version of primitiveAt for accessing contexts.
	 Written to be varargs for use from mirror primitives."
	| index value aContext spouseFP hdr fmt totalLength fixedFields stSize |
	<inline: false>
	<var: #spouseFP type: #'char *'>
	index := self stackTop.
	(objectMemory isIntegerObject: index) ifFalse:
		[self primitiveFailFor: PrimErrBadArgument.
		 ^self].
	index := objectMemory integerValueOf: index.
	aContext := self stackValue: 1.
	"Duplicating much of stObject:at:put: here allows stObject:at:put: to omit tests for contexts."
	hdr := objectMemory baseHeader: aContext.
	(objectMemory isContextHeader: hdr) ifFalse: "might be an instance of a subclass"
		[value := self stObject: aContext at: index.
		 self successful ifTrue:
			[self pop: argumentCount + 1 thenPush: value].
		 ^self].
	self externalWriteBackHeadFramePointers.
	(self isStillMarriedContext: aContext) ifFalse:
		[fmt := objectMemory formatOfHeader: hdr.
		 totalLength := objectMemory lengthOf: aContext baseHeader: hdr format: fmt.
		 fixedFields := objectMemory fixedFieldsOf: aContext format: fmt length: totalLength.
		 stSize := self fetchStackPointerOf: aContext.
		 (index between: 1 and: stSize) ifFalse:
			[self primitiveFailFor: PrimErrBadIndex.
			 ^self].			
		value := self subscript: aContext with: (index + fixedFields) format: fmt.
		self pop: argumentCount + 1 thenPush: value.
		^self].
	spouseFP := self frameOfMarriedContext: aContext.
	(index between: 1 and: (self stackPointerIndexForFrame: spouseFP)) ifFalse:
		[self primitiveFailFor: PrimErrBadIndex.
		 ^self].
	value := self temporary: index - 1 in: spouseFP.
	self pop: argumentCount + 1 thenPush: value