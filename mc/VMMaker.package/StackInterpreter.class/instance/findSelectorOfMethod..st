debug support
findSelectorOfMethod: methArg
	| meth classObj classDict classDictSize methodArray i |
	(objectMemory addressCouldBeObj: methArg) ifFalse:
		[^objectMemory nilObject].
	(objectMemory isForwarded: methArg)
		ifTrue: [meth := objectMemory followForwarded: methArg]
		ifFalse: [meth := methArg].
	 (objectMemory isOopCompiledMethod: meth) ifFalse:
		[^objectMemory nilObject].
	classObj := self methodClassOf: meth.
	(self addressCouldBeClassObj: classObj) ifTrue:
		[classDict := objectMemory fetchPointer: MethodDictionaryIndex ofObject: classObj.
		 classDictSize := objectMemory fetchWordLengthOf: classDict.
		 methodArray := objectMemory fetchPointer: MethodArrayIndex ofObject: classDict.
		 i := 0.
		 [i < (classDictSize - SelectorStart)] whileTrue:
			[meth = (objectMemory fetchPointer: i ofObject: methodArray) ifTrue:
				[^(objectMemory fetchPointer: i + SelectorStart ofObject: classDict)].
				 i := i + 1]].
	^objectMemory nilObject