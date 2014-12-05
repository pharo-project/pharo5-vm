instance creation
forCogit: aCogit
	| class |
	class := self allSubclasses
				detect: [:subclass|
						aCogit class objectMemoryClass objectRepresentationClass
						== subclass objectRepresentationClass]
				ifNone: [self error: 'cannot find subclass for the Cogit''s objectRepresentation and/or objectMemory'].
	^class new
		cogit: aCogit;
		yourself