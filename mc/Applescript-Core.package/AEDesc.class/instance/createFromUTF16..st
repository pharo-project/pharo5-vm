private
createFromUTF16: aWideString

	|bs|
	bs := aWideString asString convertToWithConverter: UTF16TextConverter new.
	(self 
		primAECreateDesc: (DescType of: 'ut16')
		from: bs) isZero ifTrue: [^self].
	self error: 'failed to create aeDesc'.
	^nil