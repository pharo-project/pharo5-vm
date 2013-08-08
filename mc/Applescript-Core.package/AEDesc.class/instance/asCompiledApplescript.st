converting
asCompiledApplescript

	| theSize |
	((self at: 1) ~= 16r73637074) ifTrue:
		[^self error: 'AEDesc is not of type ''scpt'''].
	(theSize := self dataSize) < 0 ifTrue: [^self error: 'Invalid size for data'].
	^self primAEDescToString: (CompiledApplescript new: theSize).
