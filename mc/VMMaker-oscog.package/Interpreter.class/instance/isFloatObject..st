plugin primitive support
isFloatObject: oop
	^(self isNonIntegerObject: oop)
	  and: [(self fetchClassOfNonInt: oop) = self classFloat]