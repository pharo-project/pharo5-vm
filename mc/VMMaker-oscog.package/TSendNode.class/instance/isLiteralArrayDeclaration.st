testing
isLiteralArrayDeclaration
	^selector == #cCoerce:to:
	  and: [arguments first isConstant
	  and: [arguments first value isLiteral
	  and: [arguments first value isCollection]]]