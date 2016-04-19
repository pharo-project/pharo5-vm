translation
ancilliaryClasses: options
	^(super ancilliaryClasses: options),
	  { self basicNew simStackEntryClass. self basicNew bytecodeFixupClass. CogSSOptStatus }