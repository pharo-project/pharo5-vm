constants
primitiveTable
	| cg |
	cg := CCodeGenerator new.
	cg vmClass: self.
	^PrimitiveTable collect:
		[:thing|
		(thing isInteger "quick prims, 0 for fast primitve fail"
		 or: [thing == #primitiveFail])
			ifTrue: [thing]
			ifFalse:
				[(self primitivesClass whichClassIncludesSelector: thing)
					ifNil: [#primitiveFail]
					ifNotNil:
						[:class|
						 (cg shouldIncludeMethodFor: class selector: thing)
							ifTrue: [thing]
							ifFalse: [#primitiveFail]]]]