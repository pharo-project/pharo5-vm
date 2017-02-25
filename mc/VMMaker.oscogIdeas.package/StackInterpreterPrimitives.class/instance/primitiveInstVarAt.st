object access primitives
primitiveInstVarAt
	| index rcvr hdr fmt totalLength fixedFields value |
	index := self stackTop.
	rcvr := self stackValue: 1.
	((objectMemory isNonIntegerObject: index)
	 or: [argumentCount > 1 "e.g. object:instVarAt:"
		and: [objectMemory isOopForwarded: rcvr]]) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	(objectMemory isImmediate: rcvr) ifTrue: [^self primitiveFailFor: PrimErrInappropriate].
	index := objectMemory integerValueOf: index.
	hdr := objectMemory baseHeader: rcvr.
	fmt := objectMemory formatOfHeader: hdr.
	totalLength := objectMemory lengthOf: rcvr baseHeader: hdr format: fmt.
	fixedFields := objectMemory fixedFieldsOf: rcvr format: fmt length: totalLength.
	(index >= 1 and: [index <= fixedFields]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	(fmt = objectMemory indexablePointersFormat
	 and: [objectMemory isContextHeader: hdr])
		ifTrue: [value := self externalInstVar: index - 1 ofContext: rcvr]
		ifFalse: [value := self subscript: rcvr with: index format: fmt].
	self pop: argumentCount + 1 thenPush: value