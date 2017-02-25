indexing primitives
primitiveContextAtPut
	"Special version of primitiveAtPut for accessing contexts.
	 Written to be varargs for use from mirror primitives."
	| index value aContext spouseFP hdr fmt totalLength fixedFields stSize |
	<inline: false>
	<var: #spouseFP type: #'char *'>
	value := self stackTop.
	index := self stackValue: 1.
	aContext := self stackValue: 2.
	(objectMemory isIntegerObject: index) ifFalse:
		[self primitiveFailFor: PrimErrBadArgument.
		 ^self].
	"Duplicating much of stObject:at:put: here allows stObject:at:put: to omit tests for contexts."
	hdr := objectMemory baseHeader: aContext.
	index := objectMemory integerValueOf: index.
	(objectMemory isContextHeader: hdr) ifFalse: "might be an instance of a subclass"
		[self stObject: aContext at: index put: value.
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
		self subscript: aContext with: (index + fixedFields) storing: value format: fmt.
		self pop: argumentCount + 1 thenPush: value.
		^self].
	spouseFP := self frameOfMarriedContext: aContext.
	(index between: 1 and: (self stackPointerIndexForFrame: spouseFP)) ifFalse:
		[self primitiveFailFor: PrimErrBadIndex.
		 ^self].
	self temporary: index - 1 in: spouseFP put: value.
	self pop: argumentCount + 1 thenPush: value