debug support
findSelectorOfMethod: meth forReceiver: rcvr

	| currClass done classDict classDictSize methodArray i |
	currClass := self fetchClassOf: rcvr.
	done := false.
	[done] whileFalse: [
		classDict := self fetchPointer: MethodDictionaryIndex ofObject: currClass.
		classDictSize := self numSlotsOf: classDict.
		methodArray := self fetchPointer: MethodArrayIndex ofObject: classDict.
		i := 0.
		[i <= (classDictSize - SelectorStart)] whileTrue: [
			meth = (self fetchPointer: i ofObject: methodArray) ifTrue: [
				^(self fetchPointer: i + SelectorStart ofObject: classDict)
			].
			i := i + 1.
		].
		currClass := self fetchPointer: SuperclassIndex ofObject: currClass.
		done := currClass = nilObj.
	].
	^ nilObj    "method not found in superclass chain"