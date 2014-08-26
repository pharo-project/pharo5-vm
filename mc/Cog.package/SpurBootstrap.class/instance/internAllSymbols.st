bootstrap methods
internAllSymbols
	"Ensure that all symbols in the method prototypes are interned so that later we can install them.
	 Enter them into the map, this system's symbol -> oldHeap's version.
	 Do this by interpreting Symbol intern: 'aSymbol' for each symbol."
	| internSym all symbolClass |
	internSym := self findSymbol: #intern:.
	symbolClass := self symbolClass.
	all := self allPrototypeMethodSymbols.
	oldHeap allObjectsDo:
		[:objOop| | sz |
		symbolClass = (oldHeap fetchClassOfNonImm: objOop) ifTrue:
			[sz := oldHeap numBytesOf: objOop.
			 (all detect: [:sym| sym size = sz and: [sym = (oldHeap stringOf: objOop)]]
				ifNone: nil) ifNotNil:
					[:sym|
					literalMap at: sym put: objOop.
					all remove: sym]]].
	all do: [:sym|
		(self findSymbol: sym)
			ifNotNil: [:imageSym| literalMap at: sym put: imageSym]
			ifNil:[Transcript cr; nextPutAll: 'interning '; nextPutAll: sym; flush.
				"Interpret Symbol intern: sym to ... intern it :-)"
				literalMap
					at: sym
					put: (self interpreter: oldInterpreter
							object: self symbolClass
							perform: internSym
							withArguments: {self stringFor: sym})]].
	literalMap keysAndValuesDo:
		[:symOrGlobal :imageSymOrGlobal|
		symOrGlobal isSymbol ifTrue:
			[self assert: symOrGlobal = (oldHeap stringOf: imageSymOrGlobal)]]