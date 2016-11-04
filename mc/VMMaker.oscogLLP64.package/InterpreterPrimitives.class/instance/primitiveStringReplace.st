indexing primitives
primitiveStringReplace
	" 
	<array> primReplaceFrom: start to: stop with: replacement 
	startingAt: repStart  
	<primitive: 105>
	"
	| array start stop repl replStart hdr arrayFmt totalLength arrayInstSize replFmt replInstSize srcIndex |
	array := self stackValue: 4.
	start := self stackIntegerValue: 3.
	stop := self stackIntegerValue: 2.
	repl := self stackValue: 1.
	replStart := self stackIntegerValue: 0.

	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument]. 
	(objectMemory isImmediate: repl) ifTrue: "can happen in LgInt copy"
		[^self primitiveFailFor: PrimErrBadArgument].
	(stop >= start and: [objectMemory isObjImmutable: array]) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].

	hdr := objectMemory baseHeader: array.
	arrayFmt := objectMemory formatOfHeader: hdr.
	totalLength := objectMemory lengthOf: array baseHeader: hdr format: arrayFmt.
	arrayInstSize := objectMemory fixedFieldsOf: array format: arrayFmt length: totalLength.
	(start >= 1 and: [start - 1 <= stop and: [stop + arrayInstSize <= totalLength]]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].

	hdr := objectMemory baseHeader: repl.
	replFmt := objectMemory formatOfHeader: hdr.
	totalLength := objectMemory lengthOf: repl baseHeader: hdr format: replFmt.
	replInstSize := objectMemory fixedFieldsOf: repl format: replFmt length: totalLength.
	(replStart >= 1 and: [stop - start + replStart + replInstSize <= totalLength]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].

	"Still to do: rewrite the below to accomodate short & long access"
	(objectMemory hasSpurMemoryManagerAPI
	 and: [(arrayFmt between: objectMemory firstShortFormat and: objectMemory firstLongFormat - 1)
		or: [arrayFmt = objectMemory sixtyFourBitIndexableFormat]]) ifTrue:
		[^self primitiveFailFor: PrimErrUnsupported].

	"Array formats (without byteSize bits, if bytes array) must be the same"
	arrayFmt < objectMemory firstByteFormat
		ifTrue: [arrayFmt = replFmt ifFalse:
					[^self primitiveFailFor: PrimErrInappropriate]]
		ifFalse: [(arrayFmt bitAnd: objectMemory byteFormatMask) = (replFmt bitAnd: objectMemory byteFormatMask) ifFalse:
					[^self primitiveFailFor: PrimErrInappropriate]].

	srcIndex := replStart + replInstSize - 1.
	"- 1 for 0-based access"

	arrayFmt <= objectMemory lastPointerFormat
		ifTrue:
			[start + arrayInstSize - 1 to: stop + arrayInstSize - 1 do:
				[:i |
				objectMemory storePointer: i ofObject: array withValue: (objectMemory fetchPointer: srcIndex ofObject: repl).
				srcIndex := srcIndex + 1]]
		ifFalse:
			[arrayFmt < objectMemory firstByteFormat
				ifTrue: "32-bit-word type objects"
					[start + arrayInstSize - 1 to: stop + arrayInstSize - 1 do:
						[:i |
						objectMemory storeLong32: i ofObject: array withValue: (objectMemory fetchLong32: srcIndex ofObject: repl).
						srcIndex := srcIndex + 1]]
				ifFalse: "byte-type objects"
					[start + arrayInstSize - 1 to: stop + arrayInstSize - 1 do:
						[:i |
						objectMemory storeByte: i ofObject: array withValue: (objectMemory fetchByte: srcIndex ofObject: repl).
						srcIndex := srcIndex + 1]]].
	"We might consider comparing stop - start to some value here and using forceInterruptCheck"

	self pop: argumentCount "leave rcvr on stack"