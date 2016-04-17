translation
ancilliaryClasses: options
	^(super ancilliaryClasses: options),
	  { self basicNew bytecodeFixupClass. self basicNew simStackEntryClass. CogSSOptStatus }