transformations
bindVariablesIn: aDictionary

	caseLabels := caseLabels collect: [:node| node bindVariablesIn: aDictionary].
	cases := cases collect: [:node| node bindVariablesIn: aDictionary]