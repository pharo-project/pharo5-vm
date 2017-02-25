object map
oopForObject: o
	^(o isInteger and: [o between: objectMemory minSmallInteger and: objectMemory maxSmallInteger])
		ifTrue: [o << 1 + 1]
		ifFalse:
			[o isCharacter
				ifTrue: [o asInteger << 2 + 2]
				ifFalse: [objectMap at: o ifAbsentPut: [objectMap size * 8 + (1024 * 1024)]]]