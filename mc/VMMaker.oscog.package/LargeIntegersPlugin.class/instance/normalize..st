oop functions
normalize: aLargeInteger 
	"Check for leading zeroes and return shortened copy if so."
	self debugCode: [self msg: 'normalize: aLargeInteger'].
	(interpreterProxy fetchClassOf: aLargeInteger)
		= interpreterProxy classLargePositiveInteger
		ifTrue: [^ self normalizePositive: aLargeInteger]
		ifFalse: [^ self normalizeNegative: aLargeInteger]