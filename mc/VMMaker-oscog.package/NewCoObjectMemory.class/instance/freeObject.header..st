become
freeObject: obj header: objHeader
	(self isCompiledMethodHeader: objHeader) ifTrue:
		[(self asserta: (coInterpreter methodHasCogMethod: obj) not) ifFalse:
			[self error: 'attempt to free cogged method']].
	super freeObject: obj header: objHeader