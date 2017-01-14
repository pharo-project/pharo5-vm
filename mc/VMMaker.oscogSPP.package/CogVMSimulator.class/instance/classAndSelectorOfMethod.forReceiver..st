debug support
classAndSelectorOfMethod: meth forReceiver: rcvr
	| mClass dict length methodArray |
	mClass := objectMemory fetchClassOf: rcvr.
	[dict := objectMemory fetchPointer: MethodDictionaryIndex ofObject: mClass.
	length := objectMemory numSlotsOf: dict.
	methodArray := objectMemory fetchPointer: MethodArrayIndex ofObject: dict.
	0 to: length-SelectorStart-1 do: 
		[:index | 
		meth = (objectMemory fetchPointer: index ofObject: methodArray) 
			ifTrue: [^ Array
				with: mClass
				with: (objectMemory fetchPointer: index + SelectorStart ofObject: dict)]].
	mClass := objectMemory fetchPointer: SuperclassIndex ofObject: mClass.
	mClass = objectMemory nilObject]
		whileFalse: [].
	^ Array
		with: (objectMemory fetchClassOf: rcvr)
		with: (objectMemory splObj: SelectorDoesNotUnderstand)