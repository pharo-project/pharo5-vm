printing
printStateOn: aStream
	<doNotGenerate>
	(isReceiverResultRegLive notNil
	 or: [ssEntry notNil]) ifTrue:
		[aStream
			nextPut: $(;
			print: isReceiverResultRegLive;
			space.
		ssEntry
			ifNil: [aStream nextPutAll: 'ssEntry is nil']
			ifNotNil: [ssEntry printStateOn: aStream].
		aStream nextPut: $)]