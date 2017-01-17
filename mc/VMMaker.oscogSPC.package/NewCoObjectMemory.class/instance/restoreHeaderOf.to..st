become
restoreHeaderOf: obj to: objHeader
	super restoreHeaderOf: obj to: objHeader.
	(self isCompiledMethodHeader: objHeader) ifTrue:
		[(self asserta: ((coInterpreter methodHasCogMethod: obj) not
						or: [obj = (coInterpreter cogMethodOf: obj) methodObject])) ifFalse:
			[self error: 'attempt to become cogged method']]