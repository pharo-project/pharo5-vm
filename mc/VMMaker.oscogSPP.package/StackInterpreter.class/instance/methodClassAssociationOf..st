compiled methods
methodClassAssociationOf: methodPointer
	<api>
	^self literal: (objectMemory literalCountOf: methodPointer) - 1 ofMethod: methodPointer