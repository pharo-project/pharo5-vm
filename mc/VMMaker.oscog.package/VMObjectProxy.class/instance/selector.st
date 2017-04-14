accessing
selector
	| selector |
	selector := coInterpreter maybeSelectorOfMethod: oop.
	^coInterpreter stringOf: selector