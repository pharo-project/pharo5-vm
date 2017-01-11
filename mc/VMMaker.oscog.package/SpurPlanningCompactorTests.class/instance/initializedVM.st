private
initializedVM
	| newVM |
	newVM := emptyVM cloneSimulation.
	newVM
		openOn: self class imageNameForTests extraMemory: 0;
		initStackPages.
	newVM objectMemory
		initializeMarkStack; "The Pharo bootstrap has no mark or weakling stacks :-)"
		initializeWeaklingStack.
	^newVM