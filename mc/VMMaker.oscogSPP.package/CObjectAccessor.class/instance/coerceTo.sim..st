converting
coerceTo: cTypeString sim: interpreterSimulator

	cTypeString = 'float *' ifTrue: [^ self asFloatAccessor].
	cTypeString = 'int *' ifTrue: [^ self asIntAccessor].
	^ self