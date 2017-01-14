debug printing
whereIsMaybeHeapThing: anOop
	<returnTypeC: 'char *'>
	(self oop: anOop isGreaterThanOrEqualTo: self startOfMemory andLessThan: endOfMemory) ifTrue:
		[(self oop: anOop isLessThan: freeStart) ifTrue:
			[^' is in old space'].
		 (self oop: anOop isLessThan: reserveStart) ifTrue:
			[^' is in new space'].
		 ^' is above reserve start'].
	^nil