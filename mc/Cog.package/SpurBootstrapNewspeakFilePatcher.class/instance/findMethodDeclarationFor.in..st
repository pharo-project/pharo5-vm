parsing
findMethodDeclarationFor: selector "<Symbol>" in: ast "<ClassDeclarationAST>" "^(MethodAST|nil)"
	ast instanceSide categories do:
		[:categoryAST|
		 categoryAST methods do:
			[:methodAST|
			methodAST pattern selector = selector ifTrue:
				[^methodAST]]].
	^nil