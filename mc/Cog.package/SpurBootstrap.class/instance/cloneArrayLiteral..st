bootstrap methods
cloneArrayLiteral: anArray
	"Currently serves only to clone the #(0 0) literal in SpaceTallyPROTOTYPEspaceForInstancesOf:"
	| array |
	array := oldHeap instantiateClass: (oldHeap splObj: ClassArray) indexableSize: anArray size.
	1 to: anArray size do:
		[:i| | lit |
		lit := anArray at: i.
		lit class caseOf: {
			[SmallInteger] -> [oldHeap
									storePointerUnchecked: i - 1
									ofObject: array
									withValue: (oldHeap integerObjectOf: lit)].
			[ByteSymbol] -> [oldHeap
									storePointer: i - 1
									ofObject: array
									withValue: (self findSymbol: lit)].
			[UndefinedObject] -> [oldHeap
									storePointerUnchecked: i - 1
									ofObject: array
									withValue: oldHeap nilObject] }].
	^array
