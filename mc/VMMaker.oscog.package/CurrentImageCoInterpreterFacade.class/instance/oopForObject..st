object map
oopForObject: o
	^o isInteger
		ifTrue: [o << 1 bitOr: 1]
		ifFalse: [objectMap at: o ifAbsentPut: [objectMap size * 8 + (1024 * 1024)]]