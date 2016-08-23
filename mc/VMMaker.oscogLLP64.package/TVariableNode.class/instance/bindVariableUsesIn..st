transformations
bindVariableUsesIn: aDictionary

	^ (aDictionary at: name ifAbsent: [^ self]) copy