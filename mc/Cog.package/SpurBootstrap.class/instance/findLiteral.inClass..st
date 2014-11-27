bootstrap methods
findLiteral: aLiteral inClass: classOop
	| bindingOrNil |
	aLiteral isString ifTrue:
		[^self stringFor: aLiteral].
	aLiteral isFloat ifTrue:
		[^oldHeap floatObjectOf: aLiteral].
	aLiteral isArray ifTrue:
		[^self cloneArrayLiteral: aLiteral].
	aLiteral isCharacter ifTrue:
		[^oldHeap characterObjectOf: aLiteral asciiValue].
	self assert: aLiteral isVariableBinding.
	bindingOrNil := self interpreter: oldInterpreter
						object: classOop
						perform: (self findSymbol: #bindingOf:)
						withArguments: {self findSymbol: aLiteral key}.
	bindingOrNil ~= oldHeap nilObject ifTrue:
		[^bindingOrNil].
	self error: 'couldn''t find literal ', aLiteral printString