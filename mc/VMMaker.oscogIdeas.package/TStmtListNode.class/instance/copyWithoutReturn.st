transformations
copyWithoutReturn
	self assert: self endsWithReturn.
	statements size = 1 ifTrue:
		[^statements last expression].
	^self class new
		setArguments: arguments
			statements: statements allButLast, {statements last copyWithoutReturn};
		yourself