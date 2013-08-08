object access primitives
primitiveInstVarAt
	| index rcvr hdr fmt totalLength fixedFields value |
	index := self stackIntegerValue: 0.
	rcvr := self stackValue: 1.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	hdr := self baseHeader: rcvr.
	fmt := hdr >> 8 bitAnd: 15.
	totalLength := self lengthOf: rcvr baseHeader: hdr format: fmt.
	fixedFields := self fixedFieldsOf: rcvr format: fmt length: totalLength.
	(index >= 1 and: [index <= fixedFields]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	value := self subscript: rcvr with: index format: fmt.
	self pop: argumentCount + 1 thenPush: value