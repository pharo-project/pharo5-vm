transformations
copyWithoutReturn
	self assert: self endsWithReturn.
	^self class new
		setArguments: arguments
			statements: statements allButLast, {statements last copyWithoutReturn};
		yourself