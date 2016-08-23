transformations
bindVariableUsesIn: aDictionary
	expression := expression bindVariableUsesIn: aDictionary.
	cases := (cases collect:
				[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
				{ pair first collect: [:labelNode| labelNode bindVariableUsesIn: aDictionary].
				   pair last bindVariableUsesIn: aDictionary }]).
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil := otherwiseOrNil bindVariableUsesIn: aDictionary]