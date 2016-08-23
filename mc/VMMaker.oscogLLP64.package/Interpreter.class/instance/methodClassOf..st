compiled methods
methodClassOf: methodPointer

	^ self fetchPointer: ValueIndex ofObject: (self literal: (self literalCountOf: methodPointer) - 1 ofMethod: methodPointer)