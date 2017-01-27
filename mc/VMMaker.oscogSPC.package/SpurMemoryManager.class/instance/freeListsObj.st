free space
freeListsObj
	self assert: (self firstIndexableField: (self oldSpaceObjectAfter: trueObj)) = freeLists.
	^self oldSpaceObjectAfter: trueObj