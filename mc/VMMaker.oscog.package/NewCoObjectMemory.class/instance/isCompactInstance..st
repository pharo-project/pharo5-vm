debug support
isCompactInstance: oop
	"For assert checking"
	^(self isNonImmediate: oop) and: [((self baseHeader: oop) bitAnd: CompactClassMask) ~= 0]