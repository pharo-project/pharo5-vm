private
createNull

	(self 
		primAECreateDesc: (DescType of: 'null')
		from: '') isZero ifTrue: [^self].
	self error: 'failed to create aeDesc'.
	^nil