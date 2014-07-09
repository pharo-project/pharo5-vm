assembly
popIntoLiteralVariable: aLiteral
	| litIndex |
	litIndex := encoder litIndexOrNilFor: aLiteral.
	litIndex ifNil:
		[litIndex := encoder litIndex: aLiteral].
	^encoder sizeStorePopLiteralVar: litIndex