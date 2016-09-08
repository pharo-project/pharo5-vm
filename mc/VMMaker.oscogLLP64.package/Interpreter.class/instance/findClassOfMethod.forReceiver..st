debug support
findClassOfMethod: meth forReceiver: rcvr

	| currClass classDict classDictSize methodArray i done |
	currClass := self fetchClassOf: rcvr.
	done := false.
	[done] whileFalse: [
		classDict := self fetchPointer: MethodDictionaryIndex ofObject: currClass.
		classDictSize := self numSlotsOf: classDict.
		methodArray := self fetchPointer: MethodArrayIndex ofObject: classDict.
		i := 0.
		[i < (classDictSize - SelectorStart)] whileTrue: [
			meth = (self fetchPointer: i ofObject: methodArray) ifTrue: [ ^currClass ].
			i := i + 1.
		].
		currClass := self fetchPointer: SuperclassIndex ofObject: currClass.
		done := currClass = nilObj.
	].
	^self fetchClassOf: rcvr    "method not found in superclass chain"