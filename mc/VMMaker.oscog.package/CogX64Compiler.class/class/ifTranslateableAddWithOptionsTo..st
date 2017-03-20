translation
ifTranslateableAddWithOptionsTo: aCollection
	"Override to create cogitX64.c and cogitX64Win64.c"
	(self wordSize = Cogit objectMemoryClass wordSize
	 and: [self identifyingPredefinedMacros notNil]) ifTrue:
		[aCollection
			add: {self. {#ISA. self ISA. #ABI. #SysV}};
			add: {self. {#ISA. self ISA. #ABI. #WIN64}}]