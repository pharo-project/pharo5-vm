converting
asString

	| theSize |
	(theSize := self dataSize) < 0 ifTrue: [^self error: 'Invalid size for data'].
	((self at: 1) ~= 16r54455854) ifTrue: [
		((self at: 1) ~= 16r75743136) ifTrue:
			[^self error: 'AEDesc is not of type TEXT or ut16']
		ifFalse: [
			^self asWideString
		]
	].
	^self primAEDescToString: (String new: theSize).
