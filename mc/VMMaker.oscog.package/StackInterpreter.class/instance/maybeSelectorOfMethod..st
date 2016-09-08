debug support
maybeSelectorOfMethod: methodObj
	"Answer the selector of a method, assuming its penultimate literal is either
	 a symbol or a pointer object whose first slot references the method and
	 whose second slot is a symbol (i.e. an AdditionalMethodState).  If a Symbol
	 can't be found answer nil.  This isn't satisfactory, as it puts a lot of information
	 into the VM, but it is needed for adequate crash debugging at Cadence.
	 With full blocks as of 9/2016 the last literal of a CompiledBlock is a back pointer
	 to the enclosing block or compiled method."
	| ultimateLiteral penultimateLiteral maybeSelector |
	self assert: (objectMemory isOopCompiledMethod: methodObj).
	ultimateLiteral := self ultimateLiteralOf: methodObj.
	(objectMemory isOopCompiledMethod: ultimateLiteral) ifTrue:
		[^self maybeSelectorOfMethod: ultimateLiteral].
	penultimateLiteral := self penultimateLiteralOf: methodObj.
	(objectMemory isWordsOrBytes: penultimateLiteral) ifTrue:
		[^(objectMemory fetchClassTagOfNonImm: penultimateLiteral)
			= (objectMemory fetchClassTagOfNonImm: (objectMemory splObj: SelectorDoesNotUnderstand)) ifTrue:
			[penultimateLiteral]].
	^((objectMemory isPointers: penultimateLiteral)
	 and: [(objectMemory numSlotsOf: penultimateLiteral) >= 2
	 and: [(objectMemory fetchPointer: 0 ofObject: penultimateLiteral) = methodObj
	 and: [maybeSelector := objectMemory fetchPointer: 1 ofObject: penultimateLiteral.
		(objectMemory isWordsOrBytes: maybeSelector)
	 and: [(objectMemory fetchClassTagOfNonImm: maybeSelector)
			= (objectMemory fetchClassTagOfNonImm: (objectMemory splObj: SelectorDoesNotUnderstand))]]]]) ifTrue:
		[maybeSelector]