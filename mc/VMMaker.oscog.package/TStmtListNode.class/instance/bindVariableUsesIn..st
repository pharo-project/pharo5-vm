transformations
bindVariableUsesIn: aDictionary

	statements := statements collect: [ :s | s bindVariableUsesIn: aDictionary ].