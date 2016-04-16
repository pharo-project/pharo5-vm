translation
ancilliaryClasses: options
	^(super ancilliaryClasses: options),
	  { self basicNew bytecodeFixupClass. CogSimStackEntry. CogSSOptStatus }