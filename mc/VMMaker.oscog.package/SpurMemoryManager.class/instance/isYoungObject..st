object testing
isYoungObject: objOop
	<api>
	"Answer if obj is young. Require that obj is non-immediate."
	self assert: (self isNonImmediate: objOop).
	^self oop: objOop isLessThan: newSpaceLimit