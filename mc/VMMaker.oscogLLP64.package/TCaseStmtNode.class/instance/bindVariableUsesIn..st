transformations
bindVariableUsesIn: aDictionary

	expression := expression bindVariableUsesIn: aDictionary.
	cases := cases collect: [ :c | c bindVariableUsesIn: aDictionary ].