simulation
fileValueOf: objectPointer
	| index |
	index := (interpreterProxy isIntegerObject: objectPointer)
				ifTrue: [interpreterProxy integerValueOf: objectPointer]
				ifFalse:
					[((interpreterProxy isBytes: objectPointer)
					  and: [(interpreterProxy byteSizeOf: objectPointer) = BytesPerWord]) ifFalse:
						[interpreterProxy primitiveFail.
						 ^nil].
					interpreterProxy longAt: objectPointer + BaseHeaderSize].
	^openFiles at: index