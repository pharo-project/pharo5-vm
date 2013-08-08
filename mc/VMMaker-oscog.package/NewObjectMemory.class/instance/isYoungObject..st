memory access
isYoungObject: obj
	<api>
	"Answer if obj is young. Assume obj is non-immediate."
	^self oop: obj isGreaterThanOrEqualTo: youngStart