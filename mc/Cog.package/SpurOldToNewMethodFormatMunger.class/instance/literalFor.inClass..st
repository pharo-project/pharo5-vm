munging
literalFor: aLiteral inClass: classOop
	| bindingOrNil |
	aLiteral isSymbol ifTrue:
		[^symbolOops at: aLiteral].
	aLiteral isString ifTrue:
		[^heap stringForCString: aLiteral].
	(aLiteral isInteger and: [aLiteral class == SmallInteger]) ifTrue:
		[^heap integerObjectOf: aLiteral].
	aLiteral isFloat ifTrue:
		[^heap floatObjectOf: aLiteral].
	aLiteral isArray ifTrue:
		[^self cloneArrayLiteral: aLiteral].
	self assert: aLiteral isVariableBinding.
	"interpreter
		ensureDebugAtEachStepBlock;
		instVarNamed: 'printBytecodeAtEachStep' put: true;
		instVarNamed: 'printFrameAtEachStep' put: true."
	bindingOrNil := self interpreter: interpreter
						object: classOop
						perform: (symbolOops at: #bindingOf:)
						withArguments: {symbolOops at: aLiteral key}.
	bindingOrNil ~= heap nilObject ifTrue:
		[^bindingOrNil].
	self error: 'couldn''t find literal ', aLiteral printString