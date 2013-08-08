translation
ancilliaryStructClasses
	"self ancilliaryStructClasses"
	^(super ancilliaryStructClasses copyWithout: CogBytecodeFixup),
	  { CogSSBytecodeFixup. CogSimStackEntry. CogSSOptStatus }