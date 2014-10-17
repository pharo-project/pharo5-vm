assembly
pushLiteralVariable: aLiteral
	| litIndex |
	litIndex := encoder litIndexOrNilFor: aLiteral.
	litIndex ifNil:
		[litIndex := encoder litIndex: aLiteral].
	^encoder sizePushLiteralVar: litIndex