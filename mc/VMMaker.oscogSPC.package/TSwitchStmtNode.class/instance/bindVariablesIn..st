transformations
bindVariablesIn: aDictionary
	expression := expression bindVariablesIn: aDictionary.
	cases := (cases collect:
				[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
				{ pair first collect: [:labelNode| labelNode bindVariablesIn: aDictionary].
				   pair last bindVariablesIn: aDictionary }]).
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil := otherwiseOrNil bindVariablesIn: aDictionary]