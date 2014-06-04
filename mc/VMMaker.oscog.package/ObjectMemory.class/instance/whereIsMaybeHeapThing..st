debug printing
whereIsMaybeHeapThing: anOop
	<returnTypeC: 'char *'>
	(self oop: anOop isGreaterThanOrEqualTo: self startOfMemory andLessThan: endOfMemory) ifTrue:
		[(self oop: anOop isLessThan: freeBlock) ifTrue:
			[^' is in old space'].
		 ^' is in new space'].
	^nil