assembly
pushConstant: aLiteral
	| litIndex |
	litIndex := encoder litIndexOrNilFor: aLiteral.
	litIndex ifNil:
		["rubbish way of handling special literals"
		 ([encoder genPushSpecialLiteral: aLiteral]
				on: Error
				do: [:ex| ex return: nil]) ifNotNil:
			[^self].
		 litIndex := encoder litIndex: aLiteral].
	^encoder genPushLiteral: litIndex