debug printing
whereIsMaybeCodeThing: anOop
	<api>
	<returnTypeC: 'char *'>
	(self oop: anOop isGreaterThanOrEqualTo: cogit cogCodeBase andLessThan: limitAddress) ifTrue:
		[(self oop: anOop isLessThan: cogit minCogMethodAddress) ifTrue:
			[^' is in generated runtime'].
		 (self oop: anOop isLessThan: mzFreeStart) ifTrue:
			[^' is in generated methods'].
		 (self oop: anOop isLessThan: youngReferrers) ifTrue:
			[^' is in code zone'].
		 ^' is in young referrers'].
	^nil