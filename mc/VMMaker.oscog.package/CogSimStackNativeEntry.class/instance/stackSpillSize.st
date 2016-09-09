accessing
stackSpillSize
	<returnTypeC: #sqInt>
	type caseOf: {
		[SSConstantInt64]			-> [ ^ 8 ].
		[SSConstantFloat64]		-> [ ^ 8 ].
		[SSRegisterDoubleFloat]	-> [ ^ 8 ].
		[SSRegisterPair]			-> [ ^ 8 ].
		[SSSpillFloat64]				-> [ ^ 8 ].
		[SSSpillInt64]				-> [ ^ 8 ].
	} otherwise: [^ BytesPerOop ]