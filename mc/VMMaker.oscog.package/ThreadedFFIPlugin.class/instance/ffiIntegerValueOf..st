callout support
ffiIntegerValueOf: oop
	"Support for generic callout. Answer an integer value that is coerced as C would do."
	<inline: true>
	"Cheat with a tag test"
	(oop anyMask: BytesPerWord - 1)
		ifTrue:
			[(interpreterProxy isIntegerObject: oop) ifTrue:
				[^interpreterProxy integerValueOf: oop].
			self cppIf: SPURVM
				ifTrue:
					[(interpreterProxy isCharacterObject: oop) ifTrue: "Immediate in Spur"
						[^interpreterProxy characterValueOf: oop].
					 (interpreterProxy isFloatObject: oop) ifTrue: "Immediate in 64-bit Spur"
						[^interpreterProxy floatValueOf: oop]]]
		ifFalse:
			[self cppIf: SPURVM
				ifTrue: "No non-immediate characters in Spur"
					[]
				ifFalse:
					[(interpreterProxy isCharacterObject: oop) ifTrue:
						[^interpreterProxy characterValueOf: oop]].
			 (interpreterProxy isFloatObject: oop) ifTrue:
				[^interpreterProxy floatValueOf: oop].
			 oop = interpreterProxy nilObject ifTrue: [^0]. "@@: should we really allow this????"
			 oop = interpreterProxy falseObject ifTrue: [^0].
			 oop = interpreterProxy trueObject ifTrue: [^1].
			 (interpreterProxy isLargePositiveIntegerObject: oop) ifTrue:
				[self cppIf: BytesPerWord = 8 "Use cppIf: to get the return type of the function right.  Should be sqInt on 32-bits."
					ifTrue: [^interpreterProxy positive64BitValueOf: oop]
					ifFalse: [^interpreterProxy positive32BitValueOf: oop]]].
	^interpreterProxy signedMachineIntegerValueOf: oop "<- will fail if not integer"