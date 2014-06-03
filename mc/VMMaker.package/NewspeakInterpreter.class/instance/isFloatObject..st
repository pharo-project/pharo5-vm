internal interpreter access
isFloatObject: oop
	^(self isNonIntegerObject: oop)
	  and: [(self fetchClassOfNonImm: oop) = self classFloat]