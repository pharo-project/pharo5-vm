debug printing
whereIsMaybeHeapThing: anOop
	<returnTypeC: 'char *'>
	(self isInNewSpace: anOop) ifTrue:
		[(self isInEden: anOop) ifTrue: [^' is in eden'].
		 (self isInFutureSpace: anOop) ifTrue: [^' is in future space'].
		 (self isInPastSpace: anOop) ifTrue: [^' is in past space'].
		 ^' is in new space'].
	(self isInOldSpace: anOop) ifTrue:
		[(segmentManager segmentContainingObj: anOop) ifNotNil:
			[^' is in old space'].
		 ^' is between old space segments'].
	^nil