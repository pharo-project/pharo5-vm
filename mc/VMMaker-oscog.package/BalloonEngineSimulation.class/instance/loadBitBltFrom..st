simulation
loadBitBltFrom: oop
	(bbObj isInteger or: [bbObj isNil]) ifFalse:
		[savedBBObj := bbObj].
	bbObj := oop.
	^true