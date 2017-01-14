primitive support
positive32BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or a four-byte LargePositiveInteger."
	<returnTypeC: #'unsigned int'>
	objectMemory hasSixtyFourBitImmediates
		ifTrue:
			[(objectMemory isIntegerObject: oop) ifTrue:
				[| value64 |
				value64 := objectMemory integerValueOf: oop.
				 (value64 < 0
		 			 or: [self cCode: [(self cCoerceSimple: value64 to: #'unsigned int') ~= value64]
							inSmalltalk: [value64 >> 32 ~= 0]]) ifTrue:
						[self primitiveFail. value64 := 0].
				 ^value64].
			self primitiveFail.
			^0]
		ifFalse:
			[^self maybeInlinePositive32BitValueOf: oop]