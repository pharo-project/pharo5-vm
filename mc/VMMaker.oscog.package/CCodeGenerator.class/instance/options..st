accessing
options: aDictionary
	"Set optionsDictionary to the argument and scan it for accessors on the receiver,
	 performing the accessor with the value, allowing one to specify things like
	 generateDeadCode: false in the options."
	optionsDictionary := aDictionary.
	optionsDictionary keysAndValuesDo:
		[:k :v| | accessor |
		((self class instVarNames includes: k)
		and: [(Symbol hasInterned: k, ':' ifTrue: [:s| accessor := s])
		and: [self class canUnderstand: accessor]]) ifTrue:
			[self perform: accessor with: v]]