accessing
selectAPIVariables
	^variableDeclarations reject: [:decl| decl includesSubstring: 'static ']