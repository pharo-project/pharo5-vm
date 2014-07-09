bootstrap methods
findLiteral: aLiteral
	| symbolOop smalltalk array |
	aLiteral isString ifTrue:
		[^self stringFor: aLiteral].
	aLiteral isFloat ifTrue:
		[^oldInterpreter floatObjectOf: aLiteral].
	aLiteral isArray ifTrue:
		[^self cloneArrayLiteral: aLiteral].
	self assert: aLiteral isVariableBinding.
	symbolOop := self findSymbol: aLiteral key.
	smalltalk := oldHeap splObj: 8.
	array := oldHeap fetchPointer: 1 ofObject: smalltalk.
	self assert: (oldHeap isArray: array).
	0 to: (oldHeap fetchWordLengthOf: array) - 1 do:
		[:i| | bindingOrNil |
		bindingOrNil := oldHeap fetchPointer: i ofObject: array.
		(bindingOrNil ~= oldHeap nilObject
		 and: [symbolOop = (oldHeap fetchPointer: KeyIndex ofObject: bindingOrNil)
		 and: [aLiteral key == #Smalltalk
				ifTrue:
					[(oldHeap fetchPointer: ValueIndex ofObject: bindingOrNil) = smalltalk]
				ifFalse:
					[oldInterpreter
						classNameOf: (oldHeap fetchPointer: ValueIndex ofObject: bindingOrNil)
						Is: aLiteral key]]]) ifTrue:
			[^bindingOrNil]].
	self error: 'couldn''t find literal ', aLiteral printString