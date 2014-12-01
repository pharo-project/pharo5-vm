bootstrap methods
installableMethodFor: aCompiledMethod selector: selector className: className isMeta: isMeta
	"Create a sourceless method to install in the bootstrapped image.  It will allow the
	 bootstrap to limp along until the relevant transformed Monticello package is loaded."
	| compiledMethodClass methodClassBinding methodClass sourcelessMethod bytes newMethod delta initialPC |
	compiledMethodClass := self findClassNamed: (self findSymbol: #CompiledMethod).
	methodClassBinding := self methodClassBindingForClassName: className isMeta: isMeta.
	methodClass := oldHeap fetchPointer: ValueIndex ofObject: methodClassBinding.
	"the prototypes have source pointers.  the Character methods to be replaced don't."
	sourcelessMethod := aCompiledMethod trailer hasSourcePointer
							ifTrue: [aCompiledMethod copyWithTempsFromMethodNode: aCompiledMethod methodNode]
							ifFalse: [aCompiledMethod].
	initialPC := sourcelessMethod initialPC.
	bytes := sourcelessMethod size - initialPC + 1.
	"Ugh, this is complicated.  We could be running on Spur with the new method format
	 or on non-Spur with the old format.  Make both work."
	delta := (sourcelessMethod primitive > 0
			 and: [(sourcelessMethod at: initialPC) = sourcelessMethod encoderClass callPrimitiveCode])
				ifTrue: [3]
				ifFalse: [0].
	newMethod := self
					interpreter: oldInterpreter
					object: compiledMethodClass
					perform: (self findSymbol: #newMethod:header:)
					withArguments: { oldHeap integerObjectOf: bytes - delta.
									   oldHeap integerObjectOf: (self oldFormatHeaderFor: sourcelessMethod) }.
	1 to: sourcelessMethod numLiterals - 2 do:
		[:i| | literal oop |
		literal := sourcelessMethod literalAt: i.
		oop := (literal isLiteral or: [literal isVariableBinding])
					ifTrue:
						[literal isInteger
							ifTrue: [oldInterpreter signed64BitIntegerFor: literal]
							ifFalse: [literalMap
										at: literal
										ifAbsent: [self findLiteral: literal
														inClass: methodClass]]]
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
		withValue: methodClassBinding.
	initialPC to: sourcelessMethod size - delta do:
		[:i|
		oldHeap storeByte: i - 1 ofObject: newMethod withValue: (sourcelessMethod byteAt: i + delta)].
	installedMethodOops add: newMethod.
	^newMethod