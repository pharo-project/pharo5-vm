transformations
asReturnNode
	self endsWithReturn ifTrue:
		[^self].
	^self class new
		setArguments: arguments
			statements: statements allButLast, {statements last asReturnNode};
		yourself