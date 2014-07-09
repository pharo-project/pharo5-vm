patching
substitute: ast "<ClassDeclarationAST>"
															
	SpurBootstrap new prototypeClassNameMetaSelectorMethodDo:
		[:className :isMeta :selector :method| | source |
		 method primitive = 0 ifTrue: "all primitives are in the VMMirror package"
		 	[(self findClassDeclarationFor: className in: ast) ifNotNil:
				[:classDecl|
				 (self findMethodDeclarationFor: selector in: classDecl) ifNotNil:
					[:methodDecl|
					 source := self newspeakSourceFor: method selector: selector.
					 substitutions add: {methodDecl start. methodDecl end. source}]]]]