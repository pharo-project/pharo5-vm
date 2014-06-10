debug printing
whereIsMaybeStackThing: anOop
	<returnTypeC: 'char *'>
	(self cCode:
			[self oop: anOop isGreaterThanOrEqualTo: stackMemory andLessThan: pages]
		 inSmalltalk:
			[(self memIndexFor: anOop) between: 1 and: stackMemory size]) ifTrue:
		[^' is in the stack zone'].
	^nil