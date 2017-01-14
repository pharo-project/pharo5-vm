sound primitives
primitiveConstantFillSpur
	"Fill the receiver, which must be an indexable non-pointer object, with the given integer value."
	<inline: true>
	| fillValue rcvr format end i oddBytes |
	<var: #fillValue type: #usqLong>
	<var: #end type: #usqInt>
	<var: #i type: #usqInt>
	fillValue := self positive64BitValueOf: self stackTop.
	rcvr := self stackValue: 1.
	(self successful
	 and: [(objectMemory isNonImmediate: rcvr)
	 and: [(format := objectMemory formatOf: rcvr) >= objectMemory sixtyFourBitIndexableFormat]]) ifFalse:
		[^self primitiveFail].
	format >= objectMemory firstShortFormat
		ifTrue:
			[format >= objectMemory firstByteFormat
				ifTrue:
					[(fillValue > 16rFF or: [format >= objectMemory firstCompiledMethodFormat]) ifTrue:
						[^self primitiveFail].
					 fillValue := fillValue + (fillValue << 8) + (fillValue << 16) + (fillValue << 24).
					 oddBytes := format bitAnd: 7]
				ifFalse:
					[fillValue > 16rFFFF ifTrue:
						[^self primitiveFail].
					 fillValue := fillValue + (fillValue << 16).
					 oddBytes := (format bitAnd: 3) << 1].
			 fillValue := fillValue + (fillValue << 32)]
		ifFalse:
			[format = objectMemory sixtyFourBitIndexableFormat
				ifTrue:
					[oddBytes := 0]
				ifFalse:
					[fillValue > 16rFFFFFFFF ifTrue:
						[^self primitiveFail].
					 fillValue := fillValue + (fillValue << 32).
					 oddBytes := (format bitAnd: 1) << 2]].
	end := objectMemory addressAfter: rcvr.
	i := rcvr + objectMemory baseHeaderSize.
	[i < end] whileTrue:
		[objectMemory long64At: i put: fillValue.
		 i := i + 8].
	"now ensure trailing bytes are zero"
	oddBytes > 0 ifTrue:
		[self flag: #endianness.
		 fillValue := fillValue >> (8 * oddBytes).
		 objectMemory long64At: i - 8 put: fillValue].
	self pop: 1