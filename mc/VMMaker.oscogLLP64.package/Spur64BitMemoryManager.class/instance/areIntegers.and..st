interpreter access
areIntegers: oop1 and: oop2
	"Test oop1 and oop2 to make sure both are SmallIntegers."
	^(self isIntegerObject: oop1)
	  and: [self isIntegerObject: oop2]