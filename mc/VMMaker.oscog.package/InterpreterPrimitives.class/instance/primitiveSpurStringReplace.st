indexing primitives
primitiveSpurStringReplace
	"<array> primReplaceFrom: start to: stop with: replacement startingAt: repStart  
		<primitive: 105>"
	<inline: true>
	| array start stop repl replStart arrayFmt arrayLength arrayInstSize replFmt replLength replInstSize srcDelta |
	array := self stackValue: 4.
	start := self stackValue: 3.
	stop := self stackValue: 2.
	repl := self stackValue: 1.
	replStart := self stackValue: 0.

	((objectMemory isNonIntegerObject: start)
	 or: [(objectMemory isNonIntegerObject: stop)
	 or: [(objectMemory isNonIntegerObject: replStart)
	 or: [objectMemory isImmediate: repl]]]) ifTrue: "can happen in LgInt copy"
		[^self primitiveFailFor: PrimErrBadArgument].

	start := objectMemory integerValueOf: start.
	stop := objectMemory integerValueOf: stop.
	replStart := objectMemory integerValueOf: replStart.

	(stop >= start and: [objectMemory isObjImmutable: array]) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].

	arrayFmt := objectMemory formatOf: array.
	arrayLength := objectMemory lengthOf: array format: arrayFmt.
	arrayFmt := objectMemory classFormatFromInstFormat: arrayFmt.
	replFmt := objectMemory formatOf: repl.
	replLength := objectMemory lengthOf: repl format: replFmt.
	replFmt := objectMemory classFormatFromInstFormat: replFmt.

	"Array formats (without oddFields bits) must be the same"
	(arrayFmt = replFmt
	 and: [arrayFmt < objectMemory firstCompiledMethodFormat]) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].

	"N.B. In the below start - 1 to: stop - 1 do:, Slang is intelligent enough to use < instead of <= so avoiding the stop - 1."
	arrayFmt <= objectMemory lastPointerFormat
		ifTrue:
			[arrayInstSize := objectMemory fixedFieldsOf: array format: arrayFmt length: arrayLength.
			 replInstSize := objectMemory fixedFieldsOf: repl format: replFmt length: replLength.
			 (start >= 1 and: [start - 1 <= stop and: [stop + arrayInstSize <= arrayLength
			  and: [replStart >= 1 and: [stop - start + replStart + replInstSize <= replLength]]]]) ifFalse:
				[^self primitiveFailFor: PrimErrBadIndex].
			 start := start + arrayInstSize.
			 stop := stop + arrayInstSize.
			 srcDelta := (replStart + replInstSize) - start.
			 (objectMemory isOldObject: array)
				ifTrue:
					[| mustRemember oop |
					 mustRemember := false.
					 start - 1 to: stop - 1 do:
						[:i |
						oop := objectMemory fetchPointer: srcDelta + i ofObject: repl.
						(objectMemory isYoung: oop) ifTrue:
							[mustRemember := true].
						objectMemory storePointerUnchecked: i ofObject: array withValue: oop].
					 mustRemember ifTrue:
						[objectMemory possibleRootStoreInto: array]]
				ifFalse:
					[start - 1 to: stop - 1 do:
						[:i | objectMemory storePointerUnchecked: i ofObject: array withValue: (objectMemory fetchPointer: srcDelta + i ofObject: repl)]]]
		ifFalse:
			[(start >= 1 and: [start - 1 <= stop and: [stop <= arrayLength
			  and: [replStart >= 1 and: [stop - start + replStart <= replLength]]]]) ifFalse:
				[^self primitiveFailFor: PrimErrBadIndex].
			 srcDelta := replStart - start.
			 arrayFmt >= objectMemory firstShortFormat
				ifTrue: "8 & 16-bit word type objects"
					[arrayFmt >= objectMemory firstByteFormat
						ifTrue: "byte-type objects"
							[start - 1 to: stop - 1 do:
								[:i | objectMemory storeByte: i ofObject: array withValue: (objectMemory fetchByte: srcDelta + i ofObject: repl)]]
						ifFalse: "short type objects"
							[start - 1 to: stop - 1 do:
								[:i | objectMemory storeShort16: i ofObject: array withValue: (objectMemory fetchShort16: srcDelta + i ofObject: repl)]]]
				ifFalse: "32 & 64-bit word type objects"
					[arrayFmt >= objectMemory firstLongFormat
						ifTrue: "word-type objects"
							[start - 1 to: stop - 1 do:
								[:i | objectMemory storeLong32: i ofObject: array withValue: (objectMemory fetchLong32: srcDelta + i ofObject: repl)]]
						ifFalse: "long type objects"
							[start - 1 to: stop - 1 do:
								[:i | objectMemory storeLong64: i ofObject: array withValue: (objectMemory fetchLong64: srcDelta + i ofObject: repl)]]]].
	"We might consider comparing stop - start to some value here and using forceInterruptCheck"

	self pop: argumentCount "leave rcvr on stack"