testing
findNewMethodInClassTag: classTag
"
	| cName |
	traceOn ifTrue:
		[cName := (self sizeBitsOf: class) = 16r20
			ifTrue: ['class ' , (self nameOfClass: (self fetchPointer: 6 ofObject: class))]
			ifFalse: [(self nameOfClass: class)].
		self cr; print: cName , '>>' , (self stringOf: messageSelector)].
"
	(self stringOf: messageSelector) = 'doesNotUnderstand:' ifTrue: [self halt].

	sendCount := sendCount + 1.

	printSends ifTrue:
		[self cr; print: byteCount; space; printStringOf: messageSelector; cr].
"
	(sendCount > 1000 and: [sendCount\\10 = 0]) ifTrue:
		[Transcript print: sendCount; space.
		self validate].
"
"
	(sendCount > 100150) ifTrue:
		[self qvalidate.
		messageQueue == nil ifTrue: [messageQueue := OrderedCollection new].
		messageQueue addLast: (self stringOf: messageSelector)].
"
	^super findNewMethodInClassTag: classTag