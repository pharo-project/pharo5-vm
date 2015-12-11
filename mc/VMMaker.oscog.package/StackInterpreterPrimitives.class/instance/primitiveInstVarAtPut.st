object access primitives
primitiveInstVarAtPut
	| newValue index rcvr hdr fmt totalLength fixedFields |
	newValue := self stackTop.
	index := self stackValue: 1.
	rcvr := self stackValue: 2.
	((objectMemory isNonIntegerObject: index)
	 or: [argumentCount > 2 "e.g. object:instVarAt:put:"
		and: [objectMemory isOopForwarded: rcvr]]) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	self cppIf: IMMUTABILITY
		ifTrue: [ (objectMemory isOopImmutable: rcvr) ifTrue: [^self primitiveFailFor: PrimErrInappropriate] ]
		ifFalse: [ (objectMemory isImmediate: rcvr) ifTrue: [^self primitiveFailFor: PrimErrInappropriate] ].
	index := objectMemory integerValueOf: index.
	hdr := objectMemory baseHeader: rcvr.
	fmt := objectMemory formatOfHeader: hdr.
	totalLength := objectMemory lengthOf: rcvr baseHeader: hdr format: fmt.
	fixedFields := objectMemory fixedFieldsOf: rcvr format: fmt length: totalLength.
	(index >= 1 and: [index <= fixedFields]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	(fmt = objectMemory indexablePointersFormat
	 and: [objectMemory isContextHeader: hdr])
		ifTrue: [self externalInstVar: index - 1 ofContext: rcvr put: newValue]
		ifFalse: [self subscript: rcvr with: index storing: newValue format: fmt].
	self pop: argumentCount + 1 thenPush: newValue