object access primitives
primitiveInstVarAtPut
	| newValue index rcvr hdr fmt totalLength fixedFields |
	newValue := self stackTop.
	index := self stackIntegerValue: 1.
	rcvr := self stackValue: 2.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	hdr := self baseHeader: rcvr.
	fmt := hdr >> 8 bitAnd: 15.
	totalLength := self lengthOf: rcvr baseHeader: hdr format: fmt.
	fixedFields := self fixedFieldsOf: rcvr format: fmt length: totalLength.
	(index >= 1 and: [index <= fixedFields]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	 (hdr bitAnd: ImmutabilityBit) ~= 0 ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	self subscript: rcvr with: index storing: newValue format: fmt.
	self pop: argumentCount + 1 thenPush: newValue