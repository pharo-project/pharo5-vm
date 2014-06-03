constants
primitiveAccessorDepthTable
	| cg |
	cg := CCodeGenerator new.
	cg vmClass: StackInterpreter.
	^PrimitiveTable collect:
		[:thing| |class  method |
		(thing isInteger "quick prims, 0 for fast primitve fail"
		 or: [thing == #primitiveFail
		 or: [(class := self whichClassIncludesSelector: thing) isNil]])
			ifTrue: [-1]
			ifFalse:
				[method := (class >> thing) methodNode asTranslationMethodOfClass: TMethod.
				 cg accessorDepthForMethod: method]]