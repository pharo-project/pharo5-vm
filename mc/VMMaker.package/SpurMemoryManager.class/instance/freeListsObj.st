free space
freeListsObj
	self assert: (self firstIndexableField: (self objectAfter: trueObj)) = freeLists.
	^self objectAfter: trueObj