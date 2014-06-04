accessing class hierarchy
objectMemoryClass
	initializationOptions ifNil:
		[^self defaultObjectMemoryClass].
	^Smalltalk at: (initializationOptions
					at: #ObjectMemory
					ifAbsent: [^self defaultObjectMemoryClass])