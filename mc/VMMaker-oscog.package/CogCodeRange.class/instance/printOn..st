printing
printOn: aStream
	aStream nextPut: $(.
	(startpc notNil and: [endpc notNil])
		ifTrue:
			[aStream
				nextPutAll: 'bcpcs: ';
				print: startpc;
				nextPutAll: '->';
				print: endpc]
		ifFalse:
			[aStream nextPutAll: 'startpc: '; print: startpc].
	aStream space.
	start storeOn: aStream base: 16.
	aStream nextPutAll: ' to: '.
	stop storeOn: aStream base: 16.
	step ~= 1 ifTrue: [aStream nextPutAll: ' by: '; print: step].
	aStream nextPut: $)