specifying primitives
primitive: aString parameters: anArray receiver: aClassSymbol

	fullSelector := selector.
	selector := aString asSymbol.
	anArray size == args size ifFalse: 
		[^self error: selector, ': incorrect number of parameter specifications'].
	parmSpecs := anArray collect:
		[:each | Smalltalk at: each ifAbsent:
			[^self error: selector, ': parameter spec must be a Behavior']].
	parmSpecs do: [:each | each isBehavior ifFalse:
		[^self error: selector, ': parameter spec must be a Behavior']].
	rcvrSpec := Smalltalk at: aClassSymbol asSymbol ifAbsent:
		[^self error: selector, ': receiver spec must be a Behavior'].
	rcvrSpec isBehavior ifFalse:
		[^self error: selector, ': receiver spec must be a Behavior'].
	^true