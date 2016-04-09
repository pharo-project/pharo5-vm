converting
coerceTo: cTypeString sim: interpreterSimulator

	^cTypeString caseOf: {
		['int']				-> [self ptrAddress].
		['float *']			-> [self asSingleFloatAccessor].
		['double *']			-> [self asDoubleFloatAccessor].
		['unsigned int *']	-> [self shallowCopy unitSize: 4; yourself].
		['int *']				-> [self shallowCopy unitSize: 4; yourself].
		['char *']			-> [self shallowCopy unitSize: 1; yourself].
		['unsigned char *']	-> [self shallowCopy unitSize: 1; yourself].
		['unsigned']			-> [self ptrAddress].
		['sqInt']				-> [self ptrAddress].
		['usqInt']			-> [self ptrAddress] }