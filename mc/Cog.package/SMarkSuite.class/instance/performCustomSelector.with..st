benchmarking
performCustomSelector: aSelector with: aPrefix
	| customSelector |
	customSelector := (aPrefix, aSelector capitalized) asSymbol.
	(self respondsTo: customSelector) ifTrue: [ 
		self perform: customSelector].