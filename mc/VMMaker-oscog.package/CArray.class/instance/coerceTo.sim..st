converting
coerceTo: cTypeString sim: interpreterSimulator

	^cTypeString caseOf: {
		['int']		-> [self ptrAddress].
		['float *']	-> [self asCArrayAccessor asFloatAccessor].
		['int *']		-> [self asCArrayAccessor asIntAccessor].
		['char *']	-> [self shallowCopy unitSize: 1; yourself].
		['unsigned']	-> [self ptrAddress].
		['sqInt']		-> [self ptrAddress].
		['usqInt']	-> [self ptrAddress] }