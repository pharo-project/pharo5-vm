object testing
isYoung: oop
	<api>
	"Answer if oop is young."
	^(self isNonImmediate: oop)
	 and: [self oop: oop isLessThan: newSpaceLimit]