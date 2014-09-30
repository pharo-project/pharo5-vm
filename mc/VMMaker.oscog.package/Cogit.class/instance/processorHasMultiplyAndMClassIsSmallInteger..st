initialization
processorHasMultiplyAndMClassIsSmallInteger: ignoredPrimIndex
	^(self processorHasMultiply: ignoredPrimIndex)
	   and: [self mclassIsSmallInteger: ignoredPrimIndex]