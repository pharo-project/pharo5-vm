bootstrap methods
cloneMethodProxy: proxy "<VMCompiledMethodProxy>"
	| bytes newMethod |
	bytes := proxy size - proxy initialPC + 1.
	newMethod := CompiledMethod
						newMethod: bytes
						header: proxy header.
	false
		ifTrue:
			[1 to: proxy numLiterals - 2 do:
				[:i| | literal |
				literal := (proxy literalAt: i) oop.
				literal := (oldHeap isIntegerObject: literal)
							ifTrue: [oldHeap integerValueOf: literal]
							ifFalse: ['literal', i printString].
				newMethod literalAt: i put: literal].
			newMethod
				literalAt: proxy numLiterals - 1
					put: (oldHeap stringOf: (proxy literalAt: proxy numLiterals - 1) oop) asSymbol;
				literalAt: proxy numLiterals
					put: (Smalltalk bindingOf: #Character)]
		ifFalse:
			[1 to: proxy numLiterals - 1 do:
				[:i| newMethod literalAt: i put: (proxy literalAt: i)].
			newMethod
				literalAt: proxy numLiterals
				put: (Smalltalk bindingOf: #Character)].
	proxy initialPC to: proxy size do:
		[:i| newMethod at: i put: (proxy at: i)].
	^newMethod