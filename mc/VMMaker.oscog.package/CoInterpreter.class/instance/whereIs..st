debug printing
whereIs: anOop
	<var: 'somewhere' type: #'char *'>
	(cogit whereIsMaybeCodeThing: anOop) ifNotNil: [:somewhere| ^somewhere].
	^super whereIs: anOop