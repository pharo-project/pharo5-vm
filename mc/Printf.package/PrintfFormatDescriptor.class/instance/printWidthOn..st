printing
printWidthOn: aStream
	width ~= 0 ifTrue: [width printOn: aStream].
	precision isNil ifFalse: [aStream nextPut: $.. precision printOn: aStream]