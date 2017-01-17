debugging
noAssertMethodClassAssociationOf: methodPointer
	^coInterpreter
		literal: (objectMemory literalCountOfMethodHeader: (coInterpreter noAssertHeaderOf: methodPointer)) - 1
		ofMethod: methodPointer