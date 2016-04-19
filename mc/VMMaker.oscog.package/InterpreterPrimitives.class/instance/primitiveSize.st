indexing primitives
primitiveSize
	<accessorDepth: 0>
	| rcvr hdr fmt fixedFields totalLength |
	rcvr := self stackTop.
	((objectMemory isImmediate: rcvr) "Integers are not indexable"
	 or: [hdr := objectMemory baseHeader: rcvr.
		(fmt := objectMemory formatOfHeader: hdr) < 2]) "This is not an indexable object"
		ifTrue:
			[^self primitiveFailFor: PrimErrBadReceiver].
	(fmt = objectMemory indexablePointersFormat
	 and: [objectMemory isContextHeader: hdr]) ifTrue:
		[^self primitiveContextSize].
	totalLength := objectMemory lengthOf: rcvr baseHeader: hdr format: fmt.
	fixedFields := objectMemory fixedFieldsOf: rcvr format: fmt length: totalLength.
	self pop: argumentCount + 1 thenPush: (objectMemory integerObjectOf: totalLength - fixedFields)