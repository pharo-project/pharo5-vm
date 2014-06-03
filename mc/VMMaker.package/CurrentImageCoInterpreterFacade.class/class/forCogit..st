instance creation
forCogit: aCogit
	| class |
	class := self allSubclasses
				detect: [:subclass| aCogit class objectMemoryClass = subclass objectRepresentationClass objectMemoryClass]
				ifNone: [self error: 'cannot find subclass for the Cogit''s objectRepresentation and/or objectMemory'].
	^class new
		cogit: aCogit;
		yourself