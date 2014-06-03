*VMMaker-translation support
asIf: aClass var: aString

	|index|
	index := aClass allInstVarNames 
		indexOf: aString
		ifAbsent: [self error: 'must use instVar name'].
	^self instVarAt: index
