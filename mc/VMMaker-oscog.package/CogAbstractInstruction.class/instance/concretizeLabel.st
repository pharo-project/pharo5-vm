generate machine code
concretizeLabel
	<var: #dependentChain type: #'AbstractInstruction *'>
	| dependentChain |
	dependentChain := dependent.
	[dependentChain isNil] whileFalse:
		[dependentChain updateLabel: self.
		 dependentChain := dependentChain dependent].
	^machineCodeSize := 0