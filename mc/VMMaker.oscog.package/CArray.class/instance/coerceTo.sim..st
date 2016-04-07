converting
coerceTo: cTypeString sim: interpreterSimulator

	^cTypeString caseOf: {
		['int']				-> [self ptrAddress].
		['float *']			-> [(self asCArrayAccessorUnitSize: 4) asFloatAccessor].
		['unsigned int *']	-> [(self asCArrayAccessorUnitSize: 4) asUnsignedIntAccessor].
		['int *']				-> [(self asCArrayAccessorUnitSize: 4) asIntAccessor].
		['char *']			-> [self shallowCopy unitSize: 1; yourself].
		['unsigned char *']	-> [self shallowCopy unitSize: 1; yourself].
		['unsigned']			-> [self ptrAddress].
		['sqInt']				-> [self ptrAddress].
		['usqInt']			-> [self ptrAddress] }