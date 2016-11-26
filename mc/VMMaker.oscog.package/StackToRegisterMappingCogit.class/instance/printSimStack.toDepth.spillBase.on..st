simulation only
printSimStack: aSimStack toDepth: limit spillBase: spillBase on: aStream
	<doNotGenerate>
	aStream ensureCr.
	limit < 0 ifTrue:
		[^aStream nextPutAll: 'simStackEmpty'; cr; flush].
	0 to: limit do:
		[:i|
		aStream print: i.
		i = spillBase
			ifTrue: [aStream nextPutAll: ' sb'; tab]
			ifFalse: [aStream tab; tab].
		(aSimStack at: i) printStateOn: aStream.
		aStream cr; flush]