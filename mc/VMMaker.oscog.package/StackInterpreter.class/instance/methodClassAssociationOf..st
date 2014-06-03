compiled methods
methodClassAssociationOf: methodPointer
	<api>
	^self literal: (self literalCountOf: methodPointer) - 1 ofMethod: methodPointer