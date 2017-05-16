translation
ifTranslateableAddWithOptionsTo: aCollection
	"Override to create cogitX64.c and cogitX64Win64.c"
	(self wordSize = Cogit objectMemoryClass wordSize
	 and: [self identifyingPredefinedMacros notNil]) ifTrue:
		[aCollection
			"SysV must preceed _WIN64; see Cogit class>>#generateCodeStringForCogitDotC"
			add: {self. {#ISA. self ISA. #ABI. #SysV}}; 
			add: {self. {#ISA. self ISA. #ABI. #'_WIN64'}}]