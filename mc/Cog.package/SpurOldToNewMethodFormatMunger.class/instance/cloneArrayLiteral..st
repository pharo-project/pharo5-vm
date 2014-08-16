munging
cloneArrayLiteral: anArray
	"Currently serves only to clone the #(0 0) literal in SpaceTallyPROTOTYPEspaceForInstancesOf:"
	| array |
	array := heap instantiateClass: (heap splObj: ClassArray) indexableSize: anArray size.
	1 to: anArray size do:
		[:i| | lit |
		lit := anArray at: i.
		lit class caseOf: {
			[SmallInteger] -> [heap
									storePointerUnchecked: i - 1
									ofObject: array
									withValue: (heap integerObjectOf: lit)].
			[ByteSymbol] -> [heap
									storePointer: i - 1
									ofObject: array
									withValue: (symbolOops at: lit)].
			[UndefinedObject] -> [heap
									storePointerUnchecked: i - 1
									ofObject: array
									withValue: heap nilObject] }].
	^array
