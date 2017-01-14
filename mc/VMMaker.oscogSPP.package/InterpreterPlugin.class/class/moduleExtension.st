accessing
moduleExtension
	^ self isCPP ifTrue: ['.cpp'] ifFalse: ['.c']