memory access
isYoungObject: obj
	<api>
	"Answer if obj is young. Assume obj is non-immediate."
	self assert: (self isNonImmediate: obj).
	^self oop: obj isGreaterThanOrEqualTo: youngStart