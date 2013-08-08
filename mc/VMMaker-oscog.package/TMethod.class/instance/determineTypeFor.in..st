C code generation
determineTypeFor: aTParseNode in: aCCodeGenerator
	aTParseNode isSend ifTrue:
		[^(aCCodeGenerator methodNamed: aTParseNode selector)
			ifNil: [#sqInt]
			ifNotNil: [:method| method returnType]].
	aTParseNode isAssignment ifTrue:
		[^self determineTypeFor: aTParseNode expression in: aCCodeGenerator].
	self error: 'don''t know how to extract return type from this kind of node'