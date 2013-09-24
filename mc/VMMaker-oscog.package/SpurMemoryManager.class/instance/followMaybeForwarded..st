become implementation
followMaybeForwarded: objOop
	^(self isForwarded: objOop)
		ifTrue: [self followForwarded: objOop]
		ifFalse: [objOop]