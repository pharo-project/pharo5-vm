bootstrap methods
installableMethodFor: aCompiledMethod selector: selector className: className isMeta: isMeta
	"Create a sourceless method to install in the bootstrapped image.  It will allow the
	 bootstrap to limp along until the relevant transformed Monticello package is loaded."
	| compiledMethodClass sourcelessMethod bytes newMethod |
	compiledMethodClass := self findClassNamed: (self findSymbol: #CompiledMethod).
	"the prototypes have source pointers.  the Character methods to be replaced don't."
	sourcelessMethod := aCompiledMethod trailer hasSourcePointer
							ifTrue: [aCompiledMethod copyWithTempsFromMethodNode: aCompiledMethod methodNode]
							ifFalse: [aCompiledMethod].
	bytes := sourcelessMethod size - sourcelessMethod initialPC + 1.
	newMethod := self
					interpreter: oldInterpreter
					object: compiledMethodClass
					perform: (self findSymbol: #newMethod:header:)
					withArguments: { oldHeap integerObjectOf: bytes.
									   oldHeap integerObjectOf: sourcelessMethod header }.
	1 to: sourcelessMethod numLiterals - 2 do:
		[:i| | literal oop |
		literal := sourcelessMethod literalAt: i.
		oop := (literal isLiteral or: [literal isVariableBinding])
					ifTrue:
						[literal isInteger
							ifTrue: [oldHeap integerObjectOf: literal]
							ifFalse: [literalMap at: literal ifAbsent: [self findLiteral: literal]]]
					ifFalse: "should be a VMObjectProxy"
						[literal oop].
		oldHeap storePointer: i ofObject: newMethod withValue: oop].
	oldHeap
		storePointer: sourcelessMethod numLiterals - 1
		ofObject: newMethod
		withValue: (selector isSymbol
						ifTrue: [self findSymbol: selector]
						ifFalse: [selector oop]);
		storePointer: sourcelessMethod numLiterals
		ofObject: newMethod
		withValue: (self methodClassForClassName: className
						isMeta: isMeta).
	sourcelessMethod initialPC to: sourcelessMethod size do:
		[:i|
		oldHeap storeByte: i - 1 ofObject: newMethod withValue: (sourcelessMethod byteAt: i)].
	^newMethod