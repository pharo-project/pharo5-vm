private
initializedVM
	| newVM |
	newVM := self resources anyOne current emptyVM cloneSimulation.
	newVM
		openOn: SpurImageTestResource imageNameForTests extraMemory: 0;
		initStackPages.
	newVM objectMemory
		initializeMarkStack; "The Pharo bootstrap has no mark or weakling stacks :-)"
		initializeWeaklingStack.
	^newVM