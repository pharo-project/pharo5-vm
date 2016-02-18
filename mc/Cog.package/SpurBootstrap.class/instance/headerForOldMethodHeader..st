bootstrap image
headerForOldMethodHeader: methodHeaderOop
	^self isOnSpur
		ifTrue: [self convertOldMethodHeader: methodHeaderOop]
		ifFalse: [oldHeap integerValueOf: methodHeaderOop]