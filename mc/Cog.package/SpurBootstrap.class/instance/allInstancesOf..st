bootstrap methods
allInstancesOf: classOop
	| instances |
	instances := OrderedCollection new.
	oldHeap allObjectsDo:
		[:o|
		((oldHeap isPointersNonImm: o)
		 and: [(oldHeap fetchClassOf: o) = classOop]) ifTrue:
			[instances addLast: o]].
	^instances