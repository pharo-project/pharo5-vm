assembly
pushConstant: aLiteral
	| litIndex |
	litIndex := encoder litIndexOrNilFor: aLiteral.
	litIndex ifNil:
		["rubbish way of handling special literals"
		 [(encoder sizePushSpecialLiteral: aLiteral) ifNotNil:
			[:size| ^size]]
			on: Error
			do: [:ex| ].
		 litIndex := encoder litIndex: aLiteral].
	^encoder sizePushLiteral: litIndex