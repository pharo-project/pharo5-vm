indexing primitive support
stObject: array at: index put: value
	"Do what ST would return for <obj> at: index put: value."
	| hdr fmt totalLength fixedFields stSize |
	<inline: true>
	hdr := objectMemory baseHeader: array.
	fmt := objectMemory formatOfHeader: hdr.
	totalLength := objectMemory lengthOf: array baseHeader: hdr format: fmt.
	fixedFields := objectMemory fixedFieldsOf: array format: fmt length: totalLength.
	(fmt = objectMemory indexablePointersFormat
	 and: [objectMemory isContextHeader: hdr])
		ifTrue:
			[stSize := self stackPointerForMaybeMarriedContext: array.
			((self oop: index isGreaterThanOrEqualTo: 1)
			 and: [(self oop: index isLessThanOrEqualTo: stSize)
			 and: [self isStillMarriedContext: array]]) ifTrue:
				[^self noInlineTemporary: index - 1 in: (self frameOfMarriedContext: array) put: value]]
		ifFalse: [stSize := totalLength - fixedFields].
	((self oop: index isGreaterThanOrEqualTo: (objectMemory firstValidIndexOfIndexableObject: array withFormat: fmt))
	 and: [self oop: index isLessThanOrEqualTo: stSize])
		ifTrue: [self subscript: array with: (index + fixedFields) storing: value format: fmt]
		ifFalse: [self primitiveFailFor: (fmt <= 1 ifTrue: [PrimErrBadReceiver] ifFalse: [PrimErrBadIndex])].
	^value