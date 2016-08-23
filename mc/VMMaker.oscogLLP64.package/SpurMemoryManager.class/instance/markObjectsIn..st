image segment in/out
markObjectsIn: arrayOfRoots
	"This is part of storeImageSegmentInto:outPointers:roots:."
	self setIsMarkedOf: arrayOfRoots to: true.
	0 to: (self numSlotsOf: arrayOfRoots) - 1 do:
		[:i| | oop |
		oop := self followField: i ofObject: arrayOfRoots.
		(self isNonImmediate: oop) ifTrue:
			[self setIsMarkedOf: oop to: true]]