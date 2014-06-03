printing
printStateOn: aStream
	<doNotGenerate>
	(isReceiverResultRegLive notNil
	 or: [ssEntry notNil]) ifTrue:
		[aStream
			nextPut: $(;
			print: isReceiverResultRegLive;
			space.
		ssEntry printStateOn: aStream.
		aStream nextPut: $)]