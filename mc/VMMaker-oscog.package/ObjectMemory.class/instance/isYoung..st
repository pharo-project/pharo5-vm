interpreter access
isYoung: oop
	<api>
	^(self isNonIntegerObject: oop)
	   and: [self oop: oop isGreaterThanOrEqualTo: youngStart]