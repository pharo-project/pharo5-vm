plugin primitive support
isFloatObject: oop
	^(self isNonIntegerObject: oop)
	  and: [(self fetchClassOfNonImm: oop) = self classFloat]