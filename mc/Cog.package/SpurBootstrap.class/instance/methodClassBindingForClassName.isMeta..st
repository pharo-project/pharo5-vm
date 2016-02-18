bootstrap methods
methodClassBindingForClassName: classNameSymbol isMeta: isMeta 
	| class |
	class := self findClassNamed: (literalMap at: classNameSymbol).
	isMeta ifTrue: [class := oldHeap fetchClassOfNonImm: class].
	^self interpreter: oldInterpreter
		object: class
		perform: (self findSymbol: #binding)
		withArguments: #()