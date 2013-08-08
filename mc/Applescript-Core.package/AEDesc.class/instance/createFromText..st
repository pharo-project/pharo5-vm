private
createFromText: aString

	(aString isKindOf: String) ifFalse:
		[^self error: 'TextType Data Not From String'].
	(aString isKindOf: WideString) ifTrue:
		[^self createFromUTF16: aString]
	ifFalse:[
		(self 
			primAECreateDesc: (DescType of: 'TEXT')
			from: aString) isZero ifTrue: [^self].
	].
	self error: 'failed to create aeDesc'.
	^nil