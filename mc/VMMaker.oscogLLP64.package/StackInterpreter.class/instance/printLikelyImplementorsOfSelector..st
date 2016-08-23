debug printing
printLikelyImplementorsOfSelector: selector
	"Print all methods whose penultimate literal is either selector,
	 or an object whose first inst var is the method and whose
	 second is selector (e.g. an AdditionalMethodState)."
	<api>
	objectMemory allObjectsDo:
		[:obj| | methodClassAssociation |
		((objectMemory isCompiledMethod: obj)
		 and: [(self maybeSelectorOfMethod: obj) = selector]) ifTrue:
			["try and print the key of the method class association (the name of the implementing class)"
			 methodClassAssociation := self methodClassAssociationOf: obj.
			 self printHexnp: obj;
				space;
				printOopShortInner: (((objectMemory isPointers: methodClassAssociation)
									  and: [(objectMemory numSlotsOf: methodClassAssociation) >= 2])
										ifTrue: [objectMemory fetchPointer: 0 ofObject: methodClassAssociation]
										ifFalse: [methodClassAssociation]);
				cr]]