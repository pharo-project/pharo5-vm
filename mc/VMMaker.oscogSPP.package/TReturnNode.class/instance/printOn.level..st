printing
printOn: aStream level: level

	aStream nextPut: $^.
	expression printOn: aStream level: level.