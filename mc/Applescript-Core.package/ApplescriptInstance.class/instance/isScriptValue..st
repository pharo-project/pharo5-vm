testing
isScriptValue: anOSAID

	| result |
	result := IntegerArray new: 1.
	(self 
		primOSAGetScriptInfo: anOSAID 
		type: (DescType of: 'valu')
		to: result) isZero ifFalse: [^nil].
	^(result at: 1) > 0