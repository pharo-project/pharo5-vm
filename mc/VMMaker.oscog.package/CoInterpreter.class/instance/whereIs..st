debug printing
whereIs: anOop
	<var: 'somewhere' type: #'char *'>
	(cogit whereIsMaybeCodeThing: anOop) ifNotNil: [:somewhere| ^somewhere].
	(self isOnRumpCStack: anOop) ifTrue: [^'is on rump C stack'].
	^super whereIs: anOop