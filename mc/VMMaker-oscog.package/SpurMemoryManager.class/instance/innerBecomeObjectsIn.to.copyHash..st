become implementation
innerBecomeObjectsIn: array1 to: array2 copyHash: copyHashFlag
	"Inner loop of one-way become."
	0 to: (self numSlotsOf: array1) - 1 do:
		[:i| | obj1 obj2 |
		obj1 := self fetchPointer: i ofObject: array1.
		obj2 := self fetchPointer: i ofObject: array2.
		self doBecome: obj1 to: obj2 copyHash: copyHashFlag.
		(self isForwarded: obj1) ifTrue:
			[obj1 := self followForwarded: obj1.
			 self storePointer: i ofObject: array1 withValue: obj1].
		self assert: (self isForwarded: obj2) not]