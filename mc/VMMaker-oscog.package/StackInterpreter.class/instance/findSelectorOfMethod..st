debug support
findSelectorOfMethod: meth
	| classObj classDict classDictSize methodArray i |
	(objectMemory addressCouldBeObj: meth) ifFalse:
		[^objectMemory nilObject].
	classObj := self methodClassOf: meth.
	(self addressCouldBeClassObj: classObj) ifTrue:
		[classDict := objectMemory fetchPointer: MethodDictionaryIndex ofObject: classObj.
		 classDictSize := objectMemory fetchWordLengthOf: classDict.
		 methodArray := objectMemory fetchPointer: MethodArrayIndex ofObject: classDict.
		 i := 0.
		 [i <= (classDictSize - SelectorStart)] whileTrue:
			[meth = (objectMemory fetchPointer: i ofObject: methodArray) ifTrue:
				[^(objectMemory fetchPointer: i + SelectorStart ofObject: classDict)].
				 i := i + 1]].
	^objectMemory nilObject