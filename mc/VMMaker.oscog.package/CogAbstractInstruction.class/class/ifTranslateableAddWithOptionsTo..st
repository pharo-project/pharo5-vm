translation
ifTranslateableAddWithOptionsTo: aCollection
	(self wordSize = Cogit objectMemoryClass wordSize
	 and: [self identifyingPredefinedMacros notNil]) ifTrue:
		[aCollection add: {self. {#ISA. self ISA}}]