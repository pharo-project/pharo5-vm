bootstrap methods
methodClassForClassName: classNameSymbol isMeta: isMeta 
	| class |
	class := self findClassNamed: (literalMap at: classNameSymbol).
	isMeta ifTrue: [class := oldHeap fetchClassOfNonImm: class].
	methodClasses do:
		[:mca|
		class = (oldHeap fetchPointer: ValueIndex ofObject: mca) ifTrue:
			[^mca]].
	oldHeap allObjectsDo:
		[:o| | methodClassAssociation |
		(oldHeap isCompiledMethod: o) ifTrue:
			[methodClassAssociation := oldInterpreter methodClassAssociationOf: o.
			 class == (oldHeap fetchPointer: ValueIndex ofObject: methodClassAssociation) ifTrue:
				[methodClasses add: methodClassAssociation.
				 ^methodClassAssociation]]].
	self error: 'could not find methodClassAssociation for ', classNameSymbol, (isMeta ifTrue: [' class'] ifFalse:[''])