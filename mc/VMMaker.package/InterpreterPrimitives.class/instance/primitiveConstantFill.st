sound primitives
primitiveConstantFill
	"Fill the receiver, which must be an indexable bytes or words 
	objects, with the given integer value."
	| fillValue rcvr rcvrIsBytes end i |
	<var: #end type: #usqInt>
	<var: #i type: #usqInt>
	fillValue := self positive32BitValueOf: self stackTop.
	rcvr := self stackValue: 1.
	self success: (objectMemory isWordsOrBytes: rcvr).
	rcvrIsBytes := objectMemory isBytes: rcvr.
	rcvrIsBytes ifTrue: [self success: (fillValue >= 0 and: [fillValue <= 255])].
	self successful ifTrue:
		[end := rcvr + (objectMemory sizeBitsOf: rcvr).
		i := rcvr + BaseHeaderSize.
		rcvrIsBytes
			ifTrue: [[i < end] whileTrue:
						[objectMemory byteAt: i put: fillValue.
						i := i + 1]]
			ifFalse: [[i < end] whileTrue:
						[objectMemory long32At: i put: fillValue.
						i := i + 4]].
		self pop: 1]