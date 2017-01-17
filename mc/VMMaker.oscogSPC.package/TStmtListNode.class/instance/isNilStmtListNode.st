testing
isNilStmtListNode

	|stmt|
	statements size = 1 ifFalse: [^false].
	stmt := statements at: 1.
	^ stmt isVariable and: [stmt name = 'nil']