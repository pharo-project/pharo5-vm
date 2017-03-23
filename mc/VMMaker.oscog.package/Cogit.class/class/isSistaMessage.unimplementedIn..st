in-image compilation support
isSistaMessage: aMessageOrSelector unimplementedIn: aClass
	| selector |
	selector := aMessageOrSelector selector.
	^(InstructionClient includesSelector: selector)
	   and: [(aClass includesSelector: selector) not]