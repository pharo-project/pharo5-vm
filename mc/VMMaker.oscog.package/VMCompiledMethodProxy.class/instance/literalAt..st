literals
literalAt: index 
	^VMObjectProxy new
		for: (coInterpreter literal: index - 1 ofMethod: oop)
		coInterpreter: coInterpreter
		objectMemory: objectMemory