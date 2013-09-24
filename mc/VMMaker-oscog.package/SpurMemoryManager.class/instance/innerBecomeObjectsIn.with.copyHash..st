become implementation
innerBecomeObjectsIn: array1 with: array2 copyHash: copyHashFlag
	"Inner loop of two-way become."
	0 to: (self numSlotsOf: array1) - 1 do:
		[:i| | obj1 obj2 |
		obj1 := self fetchPointer: i ofObject: array1.
		obj2 := self fetchPointer: i ofObject: array2.
		self doBecome: obj1 with: obj2 copyHash: copyHashFlag.
		(self isForwarded: obj1) ifTrue:
			[obj1 := self followForwarded: obj1.
			 self storePointer: i ofObject: array1 withValue: obj1].
		(self isForwarded: obj2) ifTrue:
			[obj2 := self followForwarded: obj2.
			 self storePointer: i ofObject: array2 withValue: obj2]]