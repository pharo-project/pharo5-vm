debug support
classAndSelectorOfMethod: meth forReceiver: rcvr
	| mClass dict length methodArray |
	mClass := self fetchClassOf: rcvr.
	[dict := self fetchPointer: MethodDictionaryIndex ofObject: mClass.
	length := self numSlotsOf: dict.
	methodArray := self fetchPointer: MethodArrayIndex ofObject: dict.
	0 to: length-SelectorStart-1 do: 
		[:index | 
		meth = (self fetchPointer: index ofObject: methodArray) 
			ifTrue: [^ Array
				with: mClass
				with: (self fetchPointer: index + SelectorStart ofObject: dict)]].
	mClass := self fetchPointer: SuperclassIndex ofObject: mClass.
	mClass = nilObj]
		whileFalse: [].
	^ Array
		with: (self fetchClassOf: rcvr)
		with: (self splObj: SelectorDoesNotUnderstand)