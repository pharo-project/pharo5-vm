debugging traps
commonSend
	| i |
	printSends ifTrue:
		[self print: byteCount; space; printStringOf: messageSelector; cr].
	(i := breakSelector basicSize) = (self lengthOf: messageSelector) ifTrue:
		[[i > 0] whileTrue:
			[(self fetchByte: i - 1 ofObject: messageSelector) = (breakSelector at: i) asInteger
				ifTrue: [(i := i - 1) = 0 ifTrue: [self halt: 'Send of ', breakSelector]]
				ifFalse: [i := 0]]].
	^super commonSend