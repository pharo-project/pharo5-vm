transformations
replaceNodesIn: aDictionary
	^aDictionary
		at: self
		ifAbsent:
			[expression := expression replaceNodesIn: aDictionary.
			 cases := (cases collect:
						[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
						{ pair first collect: [:labelNode| labelNode replaceNodesIn: aDictionary].
						   pair last replaceNodesIn: aDictionary }]).
			 otherwiseOrNil ifNotNil:
				[otherwiseOrNil := otherwiseOrNil replaceNodesIn: aDictionary].
			 self]