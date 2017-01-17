accessing class hierarchy
coreInterpreterClass
	"While the interpreterClass/vmClass for translation may be
	 a subclass that holds a few primitives we want the actual
	 interpreter name at the head of the generated file."
	^((name endsWith: 'Primitives')
	   and: [name beginsWith: superclass name])
		ifTrue: [superclass]
		ifFalse: [self]