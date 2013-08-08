debugging
noAssertMethodClassAssociationOf: methodPointer
	^coInterpreter
		literal: (coInterpreter literalCountOfHeader: (coInterpreter noAssertHeaderOf: methodPointer)) - 1
		ofMethod: methodPointer