debug printing
whereIs: anOop
	(self isOnRumpCStack: anOop) ifTrue: [^'is on rump C stack'].
	^super whereIs: anOop