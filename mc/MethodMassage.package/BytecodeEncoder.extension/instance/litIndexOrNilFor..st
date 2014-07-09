*MethodMassage-literal access
litIndexOrNilFor: aLiteral
	| index |
	index := aLiteral isVariableBinding
				ifTrue: [literalStream originalContents identityIndexOf: aLiteral ifAbsent: [^nil]]
				ifFalse: [literalStream originalContents indexOf: aLiteral ifAbsent: [^nil]].
	^index <= literalStream position ifTrue:
		[index - 1]