object testing
isOldObject: objOop
	<api>
	"Answer if obj is old. Require that obj is non-immediate."
	self assert: (self isNonImmediate: objOop).
	^self oop: objOop isGreaterThanOrEqualTo: oldSpaceStart