translated primitives
methodOrNilForTranslatedPrimitiveSelector: selector
	self translatedPrimitives do:
		[:tuple| | method |
		method := self methodForTranslatedPrimitiveTuple: tuple.
		method pragmas do:
			[:p|
			((p keyword beginsWith: 'primitive:') and: [p arguments first = selector]) ifTrue:
				[^method]]].
	^nil