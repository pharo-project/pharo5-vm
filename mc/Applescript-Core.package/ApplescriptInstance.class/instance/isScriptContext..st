testing
isScriptContext: anOSAID

	| result |
	result := IntegerArray new: 1.
	(self 
		primOSAGetScriptInfo: anOSAID 
		type: (DescType of: 'cntx')
		to: result) isZero ifFalse: [^nil].
	^(result at: 1) > 0