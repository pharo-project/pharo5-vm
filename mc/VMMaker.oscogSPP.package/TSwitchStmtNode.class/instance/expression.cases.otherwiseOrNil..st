instance initialization
expression: expr cases: aTBraceNode otherwiseOrNil: otherwiseOrNilNode

	self expression: expr.
	self cases: (self createCasesFromBraceNode: aTBraceNode).
	self otherwiseOrNil: otherwiseOrNilNode