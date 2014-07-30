become implementation
innerBecomeObjectsIn: array1 and: array2 copyHash: copyHashFlag
	"Inner loop of two-way become."
	0 to: (self numSlotsOf: array1) - 1 do:
		[:i| | obj1 obj2 |
		"At first blush it would appear unnecessary to use followField: here since
		 the validation in become:with:twoWay:copyHash: follows forwarders.  But
		 there's nothing to ensure all elements of each array are unique and don't
		 appear in the other array.  So the enumeration could encounter an object
		 already becommed earlier in the same enumeration."
		obj1 := self followField: i ofObject: array1.
		obj2 := self followField: i ofObject: array2.
		obj1 ~= obj2 ifTrue:
			[self doBecome: obj1 and: obj2 copyHash: copyHashFlag.
			 self followField: i ofObject: array1.
			 self followField: i ofObject: array2]]