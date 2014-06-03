translation
specialValueForConstant: constantName default: defaultValue
	constantName = 'DoAssertionChecks' ifTrue:
		[^'(!PRODUCTION)'].
	constantName = 'AllocationCheckFiller' ifTrue:
		[^('#if !defined(AllocationCheckFiller)\# define AllocationCheckFiller ', defaultValue, '\#endif') withCRs].
	^super specialValueForConstant: constantName default: defaultValue