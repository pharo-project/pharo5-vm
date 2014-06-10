debug printing
printLikelyImplementorsOfSelector: selector
	"Print all methods whose penultimate literal is either selector,
	 or an object whose first inst var is the method and whose
	 second is selector (e.g. an AdditionalMethodState)."
	<api>
	objectMemory allObjectsDo:
		[:obj| | penultimateLiteral methodClassAssociation |
		(objectMemory isCompiledMethod: obj) ifTrue:
			[penultimateLiteral := self penultimateLiteralOf: obj.
			 (penultimateLiteral = selector
			 or: [(objectMemory isPointers: penultimateLiteral)
				and: [(objectMemory numSlotsOf: penultimateLiteral) >= 2
				and: [(objectMemory fetchPointer: 0 ofObject: penultimateLiteral) = obj
				and: [(objectMemory fetchPointer: 1 ofObject: penultimateLiteral) = selector]]]]) ifTrue:
				["try and print the key of the method class association (the name of the implementing class)"
				 methodClassAssociation := self methodClassAssociationOf: obj.
				 self printHexnp: obj;
					space;
					printOopShortInner: (((objectMemory isPointers: methodClassAssociation)
										  and: [(objectMemory numSlotsOf: methodClassAssociation) >= 2])
											ifTrue: [objectMemory fetchPointer: 0 ofObject: methodClassAssociation]
											ifFalse: [methodClassAssociation]);
					cr]]]