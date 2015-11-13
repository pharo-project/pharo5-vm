accessing
selectAPIVariables
	^variableDeclarations reject: [:decl| decl includesSubString: 'static ']