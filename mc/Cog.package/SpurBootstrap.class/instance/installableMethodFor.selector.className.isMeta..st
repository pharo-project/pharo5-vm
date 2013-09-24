bootstrap methods
installableMethodFor: aCompiledMethod selector: selector className: className isMeta: isMeta
	| compiledMethodClass sourcelessMethod bytes newMethod methodClass |
	compiledMethodClass := self findClassNamed: (self findSymbol: #CompiledMethod).
	"the prototypes hve source pointers.  the Character methods to be replaced don't."
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
	1 to: sourcelessMethod numLiterals - 1 do:
		[:i| | literal oop |
		literal := sourcelessMethod literalAt: i.
		literal isMethodProperties ifTrue:
			[literal := selector].
		oop := (literal isLiteral or: [literal isVariableBinding])
					ifTrue:
						[literal isInteger
							ifTrue: [oldHeap integerObjectOf: literal]
							ifFalse: [literalMap at: literal ifAbsent: [self findLiteral: literal]]]
					ifFalse: "should be a VMObjectProxy"
						[literal oop].
		oldHeap storePointer: i ofObject: newMethod withValue: oop].
	methodClass := self methodClassForClassName: className isMeta: isMeta.
	oldHeap storePointer: sourcelessMethod numLiterals ofObject: newMethod withValue: methodClass.
	sourcelessMethod initialPC to: sourcelessMethod size do:
		[:i|
		oldHeap storeByte: i - 1 ofObject: newMethod withValue: (sourcelessMethod byteAt: i)].
	^newMethod