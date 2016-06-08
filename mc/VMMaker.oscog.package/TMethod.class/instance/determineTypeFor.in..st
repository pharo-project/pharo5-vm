C code generation
determineTypeFor: aNode in: aCodeGen
	aNode isSend ifTrue:
		[^aCodeGen returnTypeForSend: aNode in: self ifNil: #sqInt].
	aNode isAssignment ifTrue:
		[^self determineTypeFor: aNode expression in: aCodeGen].
	self error: 'don''t know how to extract return type from this kind of node'