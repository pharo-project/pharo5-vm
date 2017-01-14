accessing
functionPointerFor: primIndex inClass: lookupClass
	^primIndex = 0
		ifTrue: [#primitiveFail]
		ifFalse: [coInterpreter functionPointerFor: primIndex inClass: lookupClass]