debug support
findClassContainingMethod: meth startingAt: classObj
	| currClass classDict classDictSize methodArray i |
	currClass := classObj.
	[self assert: (objectMemory isForwarded: currClass) not.
	 classDict := objectMemory fetchPointer: MethodDictionaryIndex ofObject: currClass.
	 self assert: (objectMemory isForwarded: classDict) not.
	 classDictSize := objectMemory fetchWordLengthOf: classDict.
	 methodArray := objectMemory fetchPointer: MethodArrayIndex ofObject: classDict.
	 self assert: (objectMemory isForwarded: methodArray) not.
	 i := 0.
	 [i < (classDictSize - SelectorStart)] whileTrue:
		[meth = (objectMemory fetchPointer: i ofObject: methodArray) ifTrue:
			[^currClass].
		 i := i + 1].
	 currClass := self superclassOf: currClass.
	 currClass = objectMemory nilObject] whileFalse.
	^currClass		"method not found in superclass chain"