object testing
isReallyYoungObject: objOop
	<api>
	"Answer if obj is young. Require that obj is non-immediate. Override to filter-out Cog methods"
	self assert: (self isNonImmediate: objOop).
	^(self oop: objOop isLessThan: newSpaceLimit)
	  and: [self oop: objOop isGreaterThanOrEqualTo: newSpaceStart]