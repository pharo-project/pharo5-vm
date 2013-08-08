garbage collection
shouldAnnotateObjectReference: anOop
	"self assert: ((objectMemory isIntegerObject: anOop)
				or: [objectMemory addressCouldBeObj: anOop])."
	^(objectMemory isNonIntegerObject: anOop)
	  and: [self oop: anOop isGreaterThan: objectMemory trueObject]