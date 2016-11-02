sound primitives
primitiveConstantFillV3
	"Fill the receiver, which must be an indexable bytes or words 
	 object, with the given integer value."
	<inline: true>
	| fillValue rcvr end i |
	<var: #end type: #usqInt>
	<var: #i type: #usqInt>
	fillValue := self positive32BitValueOf: self stackTop.
	rcvr := self stackValue: 1.
	self success: (objectMemory isWordsOrBytes: rcvr).
	(objectMemory isBytes: rcvr) ifTrue:
		[self success: (fillValue >= 0 and: [fillValue <= 255]).
		 fillValue := fillValue + (fillValue << 8) + (fillValue << 16) + (fillValue << 24)].
	self successful ifTrue:
		[end := rcvr + (objectMemory sizeBitsOf: rcvr).
		 i := rcvr + objectMemory baseHeaderSize.
		 [i < end] whileTrue:
			[objectMemory long32At: i put: fillValue.
			 i := i + 4].
		 self pop: 1]