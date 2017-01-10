private
initializedVM
	^emptyVM cloneSimulation
		openOn: self class imageNameForTests extraMemory: 0;
		initStackPages;
		yourself