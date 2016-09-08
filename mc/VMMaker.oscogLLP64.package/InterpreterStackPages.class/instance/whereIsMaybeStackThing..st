debug printing
whereIsMaybeStackThing: anOop
	"If anOop is an address within the stack zone answer a string stating that, otherwise answer nil."
	<returnTypeC: 'char *'>
	(self cCode:
			[self oop: anOop isGreaterThanOrEqualTo: stackMemory andLessThan: pages]
		 inSmalltalk:
			[(self memIndexFor: anOop) between: 1 and: stackMemory size]) ifTrue:
		[^' is in the stack zone'].
	^nil