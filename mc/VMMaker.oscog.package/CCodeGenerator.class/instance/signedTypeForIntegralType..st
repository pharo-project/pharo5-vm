type inference
signedTypeForIntegralType: aCTypeString
	(aCTypeString beginsWith: 'unsigned ') ifTrue:
		[^aCTypeString allButFirst: 8].
	
	(aCTypeString beginsWith: 'usq') ifTrue:
		[^aCTypeString allButFirst].

	self error: 'unknown type'.
	^#long