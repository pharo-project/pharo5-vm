debug support
findClassForSelector: aSelector lookupClass: startClass do: unaryBlock
	"Search startClass' class hierarchy looking for aSelector and if found, evaluate unaryBlock
	 with the class where the selector is found.  Otherwise evaluate unaryBlock with nil."
	| currClass classDict classDictSize i |
	currClass := startClass.
	[classDict := objectMemory fetchPointer: MethodDictionaryIndex ofObject: currClass.
	 classDictSize := objectMemory numSlotsOf: classDict.
	 i := SelectorStart.
	 [i < classDictSize] whileTrue:
		[aSelector = (objectMemory fetchPointer: i ofObject: classDict) ifTrue:
			[^unaryBlock value: currClass].
			i := i + 1].
	 currClass := self superclassOf: currClass.
	 currClass = objectMemory nilObject] whileFalse.
	^unaryBlock value: nil    "selector not found in superclass chain"
		