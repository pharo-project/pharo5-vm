object access primitives
primitiveInstVarAt
	| index rcvr hdr fmt totalLength fixedFields value |
	index := self stackTop.
	rcvr := self stackValue: 1.
	((objectMemory isNonIntegerObject: index)
	 or: [argumentCount > 1 "e.g. object:instVarAt:"
		and: [objectMemory isOopForwarded: rcvr]]) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	index := objectMemory integerValueOf: index.
	hdr := self baseHeader: rcvr.
	fmt := objectMemory formatOfHeader: hdr.
	totalLength := self lengthOf: rcvr baseHeader: hdr format: fmt.
	fixedFields := self fixedFieldsOf: rcvr format: fmt length: totalLength.
	(index >= 1 and: [index <= fixedFields]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	value := self subscript: rcvr with: index format: fmt.
	self pop: argumentCount + 1 thenPush: value