translation
ancilliaryClasses: options
	^((super ancilliaryClasses: options) copyWithout: CogBytecodeFixup),
	  { CogSSBytecodeFixup. CogSimStackEntry. CogSSOptStatus }