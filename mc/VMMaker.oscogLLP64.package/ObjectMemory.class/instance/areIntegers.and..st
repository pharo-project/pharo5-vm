interpreter access
areIntegers: oop1 and: oop2
	"Test oop1 and oop2 to make sure both are SmallIntegers."
	^((oop1 bitAnd: oop2) bitAnd: 1) ~= 0