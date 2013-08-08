copying
postCopy
	expression := expression copy.
	cases := (cases collect:
				[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
				{ pair first collect: [:labelNode| labelNode copy].
				   pair last copy }]).
	otherwiseOrNil := otherwiseOrNil copy