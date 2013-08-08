indexing primitives
primitiveContextSize
	"Special version of primitiveSize for accessing contexts.
	 Written to be varargs for use from mirror primitives."
	| rcvr sz hdr fmt totalLength fixedFields |
	<inline: false>
	rcvr := self stackTop.
	hdr := objectMemory baseHeader: rcvr.
	fmt := objectMemory formatOfHeader: hdr.
	totalLength := objectMemory lengthOf: rcvr baseHeader: hdr format: fmt.
	fixedFields := objectMemory fixedFieldsOf: rcvr format: fmt length: totalLength.
	(objectMemory isContextHeader: hdr)
		ifTrue:
			[self externalWriteBackHeadFramePointers.
			sz := self stackPointerForMaybeMarriedContext: rcvr]
		ifFalse: [sz := totalLength - fixedFields].
	self pop: argumentCount + 1 thenPush: (objectMemory integerObjectOf: sz)