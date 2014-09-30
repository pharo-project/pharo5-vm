initialization
processorHasDivQuoRemAndMClassIsSmallInteger: ignoredPrimIndex
	^(self processorHasDivQuoRem: ignoredPrimIndex)
	   and: [self mclassIsSmallInteger: ignoredPrimIndex]