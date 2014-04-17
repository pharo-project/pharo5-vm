internal interpreter access
isFloatObject: oop
	^(self isNonIntegerObject: oop)
	  and: [(self fetchClassOfNonInt: oop) = self classFloat]