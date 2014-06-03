running
setUp
	(self respondsTo: #timeout: )
		ifTrue: [self perform: #timeout: with: 10]
