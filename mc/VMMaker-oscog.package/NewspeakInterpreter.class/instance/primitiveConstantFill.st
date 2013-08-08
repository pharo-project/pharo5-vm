sound primitives
primitiveConstantFill
	"Fill the receiver, which must be an indexable bytes or words 
	objects, with the given integer value."
	| fillValue rcvr rcvrIsBytes end i |
	fillValue := self positive32BitValueOf: self stackTop.
	rcvr := self stackValue: 1.
	self success: (self isWordsOrBytes: rcvr).
	rcvrIsBytes := self isBytes: rcvr.
	rcvrIsBytes ifTrue: [self success: (fillValue >= 0 and: [fillValue <= 255])].
	self successful
		ifTrue: [end := rcvr + (self sizeBitsOf: rcvr).
			i := rcvr + BaseHeaderSize.
			rcvrIsBytes
				ifTrue: [[i < end]
						whileTrue: [self byteAt: i put: fillValue.
							i := i + 1]]
				ifFalse: [[i < end]
						whileTrue: [self long32At: i put: fillValue.
							i := i + 4]].
			self pop: 1]