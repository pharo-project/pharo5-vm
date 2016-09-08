debug support
findSelectorOfMethod: meth
	| classObj classDict classDictSize methodArray i |
	(objectMemory addressCouldBeObj: meth) ifFalse:
		[^objectMemory nilObject].
	(objectMemory isForwarded: meth) ifTrue:
		[^self findSelectorOfMethod: (objectMemory followForwarded: meth)].
	 (objectMemory isOopCompiledMethod: meth) ifFalse:
		[^objectMemory nilObject].
	(self maybeSelectorOfMethod: meth) ifNotNil:
		[:selector| ^selector].
	classObj := self safeMethodClassOf: meth.
	(self addressCouldBeClassObj: classObj) ifTrue:
		[classDict := objectMemory fetchPointer: MethodDictionaryIndex ofObject: classObj.
		 classDictSize := objectMemory numSlotsOf: classDict.
		 classDictSize > MethodArrayIndex ifTrue:
			[methodArray := objectMemory fetchPointer: MethodArrayIndex ofObject: classDict.
			 i := 0.
			 [i < (classDictSize - SelectorStart)] whileTrue:
				[meth = (objectMemory fetchPointer: i ofObject: methodArray) ifTrue:
					[^(objectMemory fetchPointer: i + SelectorStart ofObject: classDict)].
					 i := i + 1]]].
	^objectMemory nilObject