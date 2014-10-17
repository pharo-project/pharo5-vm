parsing
findClassDeclarationFor: className in: ast "<ClassDeclarationAST>" "^(ClassDeclarationAST|nil)"
	^ast instanceSide nestedClasses
		detect: [:classDecl| classDecl name = className]
		ifNone: []