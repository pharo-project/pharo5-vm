transformations
bindVariablesIn: aDictionary

	expression := expression bindVariablesIn: aDictionary.
	cases := cases collect: [ :c | c bindVariablesIn: aDictionary ].