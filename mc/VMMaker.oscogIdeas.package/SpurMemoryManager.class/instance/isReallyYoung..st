object testing
isReallyYoung: oop
	<api>
	"Answer if oop is young."
	^(self isNonImmediate: oop)
	 and: [self isReallyYoungObject: oop]