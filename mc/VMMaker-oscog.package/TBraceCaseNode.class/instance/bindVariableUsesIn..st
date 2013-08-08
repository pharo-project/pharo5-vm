transformations
bindVariableUsesIn: aDictionary

	caseLabels := caseLabels collect: [:node| node bindVariableUsesIn: aDictionary].
	cases := cases collect: [:node| node bindVariableUsesIn: aDictionary]