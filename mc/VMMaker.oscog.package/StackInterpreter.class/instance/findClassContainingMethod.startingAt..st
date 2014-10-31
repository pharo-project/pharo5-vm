debug support
findClassContainingMethod: meth startingAt: classObj
	| currClass classDict classDictSize methodArray i |
	(objectMemory isOopForwarded: classObj)
		ifTrue: [currClass := objectMemory followForwarded: classObj]
		ifFalse: [currClass := classObj].
	[self assert: (objectMemory isForwarded: currClass) not.
	 (self addressCouldBeClassObj: currClass) ifFalse:
		[^objectMemory nilObject].
	 classDict := objectMemory noFixupFollowField: MethodDictionaryIndex ofObject: currClass.
	 self assert: (objectMemory isForwarded: classDict) not.
	 classDictSize := objectMemory numSlotsOf: classDict.
	 classDictSize > MethodArrayIndex ifTrue:
		[methodArray := objectMemory noFixupFollowField: MethodArrayIndex ofObject: classDict.
		 self assert: (objectMemory isForwarded: methodArray) not.
		 i := 0.
		 [i < (classDictSize - SelectorStart)] whileTrue:
			[meth = (objectMemory noFixupFollowField: i ofObject: methodArray) ifTrue:
				[^currClass].
			 i := i + 1]].
	 currClass := self noFixupSuperclassOf: currClass.
	 currClass = objectMemory nilObject] whileFalse.
	^currClass		"method not found in superclass chain"