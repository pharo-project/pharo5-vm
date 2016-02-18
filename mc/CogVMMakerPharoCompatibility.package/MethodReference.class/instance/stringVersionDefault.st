accessing
stringVersionDefault

	^classSymbol, (classIsMeta ifTrue: [ ' class ' ] ifFalse: [' ']), methodSymbol  