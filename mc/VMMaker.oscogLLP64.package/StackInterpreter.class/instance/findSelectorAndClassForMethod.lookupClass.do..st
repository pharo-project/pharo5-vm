debug support
findSelectorAndClassForMethod: meth lookupClass: startClass do: binaryBlock
	"Search startClass' class hierarchy searching for method and if found, evaluate aBinaryBlock
	 with the selector and class where the method is found.  Otherwise evaluate aBinaryBlock
	 with doesNotUnderstand: and nil."
	| currClass classDict classDictSize methodArray i |
	currClass := startClass.
	[classDict := objectMemory fetchPointer: MethodDictionaryIndex ofObject: currClass.
	 classDictSize := objectMemory numSlotsOf: classDict.
	 classDictSize > MethodArrayIndex ifTrue:
		[methodArray := objectMemory fetchPointer: MethodArrayIndex ofObject: classDict.
		 i := 0.
		 [i <= (classDictSize - SelectorStart)] whileTrue:
			[meth = (objectMemory fetchPointer: i ofObject: methodArray) ifTrue:
				[^binaryBlock
					value: (objectMemory fetchPointer: i + SelectorStart ofObject: classDict)
					value: currClass].
				i := i + 1]].
	 currClass := self superclassOf: currClass.
	 currClass = objectMemory nilObject] whileFalse.
	^binaryBlock    "method not found in superclass chain"
		value: (objectMemory splObj: SelectorDoesNotUnderstand)
		value: nil