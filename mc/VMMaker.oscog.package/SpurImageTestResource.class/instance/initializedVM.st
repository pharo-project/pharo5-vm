accessing
initializedVM
	vmWithLoadedImage ifNil:
		[vmWithLoadedImage := StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager).
		 vmWithLoadedImage
			openOn: self class imageNameForTests extraMemory: 0.
		vmWithLoadedImage objectMemory
			initializeMarkStack; "The Pharo bootstrap has no mark or weakling stacks :-)"
			initializeWeaklingStack].
	^vmWithLoadedImage