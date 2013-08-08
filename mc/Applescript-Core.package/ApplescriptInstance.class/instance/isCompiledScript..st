testing
isCompiledScript: anOSAID

	| result |
	result := IntegerArray new: 1.
	(self 
		primOSAGetScriptInfo: anOSAID 
		type: (DescType of: 'cscr')
		to: result) isZero ifFalse: [^nil].
	^(result at: 1) > 0