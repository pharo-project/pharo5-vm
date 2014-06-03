translation
isAccessor: aSelector
	^(#(cogit coInterpreter objectMemory) includes: aSelector) not
	   and: [super isAccessor: aSelector]