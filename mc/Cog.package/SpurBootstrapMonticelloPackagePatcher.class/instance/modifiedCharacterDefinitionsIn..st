private-accessing
modifiedCharacterDefinitionsIn: definitions
	| rewriter |
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: 'value' with: 'self asInteger';
		replace: 'value := ``@args' with: 'DELETEME'.
	^(((definitions select: [:d| d isMethodDefinition and: [d fullClassName = #Character]])
		collect: [:d| { d. self patchDefinition: d withRewriter: rewriter} ]
		thenSelect: [:pair| pair first source ~= pair second source])
			collect: [:pair| pair second])