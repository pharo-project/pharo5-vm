transformations
removeAssertions
	expression removeAssertions.
	cases do:
		[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
		pair first do: [:labelNode| labelNode removeAssertions].
		pair last removeAssertions].
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil removeAssertions]