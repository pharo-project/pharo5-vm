become implementation
doBecome: obj1 with: obj2 copyHash: copyHashFlag
	((self isClassInClassTable: obj1)
	 or: [self isClassInClassTable: obj1]) ifTrue:
		[self halt].
	(self numSlotsOf: obj1) = (self numSlotsOf: obj2)
		ifTrue:
			[self inPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag]
		ifFalse:
			[self outOfPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag]