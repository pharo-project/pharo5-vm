C translation support
stepExpressionIsNegative: aNode
	"Answer if the step expression (the by: argument in a to:by:do:) is negative."
	self isConstantNode: aNode valueInto: [:stepValue| ^stepValue < 0].
	(aNode isSend and: [aNode selector == #negated]) ifTrue:
		[self isConstantNode: aNode receiver valueInto: [:stepValue| ^stepValue > 0]].
	^false