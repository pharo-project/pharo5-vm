constants
primitiveAccessorDepthTable
	| cg |
	cg := CCodeGenerator new.
	cg vmClass: StackInterpreter.
	^self primitiveTable collect:
		[:thing| | implementingClass method |
		(thing isInteger "quick prims, 0 for fast primitve fail"
		 or: [thing == #primitiveFail
		 or: [(implementingClass := self primitivesClass whichClassIncludesSelector: thing) isNil]])
			ifTrue: [-1]
			ifFalse:
				[method := cg compileToTMethodSelector: thing in: implementingClass.
				 cg accessorDepthForMethod: method]]