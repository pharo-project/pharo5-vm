compile abstract instructions
genAddSmallIntegerTagsTo: aRegister
	cogit AddCq: 1 R: aRegister.
	^0