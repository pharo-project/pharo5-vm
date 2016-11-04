type inference
signedTypeForIntegralType: aCTypeString
	(aCTypeString beginsWith: 'unsigned ') ifTrue:
		[^aCTypeString allButFirst: 8].
	
	(aCTypeString beginsWith: 'usq') ifTrue:
		[^aCTypeString allButFirst].

	aCTypeString = 'size_t' ifTrue: [^#usqIntptr_t].
	
	self error: 'unknown type'.
	^#long