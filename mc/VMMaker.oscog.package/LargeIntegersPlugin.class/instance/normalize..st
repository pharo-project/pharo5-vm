oop functions
normalize: aLargeInteger 
	"Check for leading zeroes and return shortened copy if so."
	self debugCode: [self msg: 'normalize: aLargeInteger'].
	(interpreterProxy isLargePositiveIntegerObject: aLargeInteger)
		ifTrue: [^ self normalizePositive: aLargeInteger]
		ifFalse: [^ self normalizeNegative: aLargeInteger]