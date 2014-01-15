debugging traps
commonSend
	printSends ifTrue:
		[self print: byteCount; space; printStringOf: messageSelector; cr].
	^super commonSend