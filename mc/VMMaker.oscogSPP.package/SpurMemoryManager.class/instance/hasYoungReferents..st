object testing
hasYoungReferents: objOop
	0 to: (self numPointerSlotsOf: objOop) - 1 do:
		[:i| | oop |
		oop := self fetchPointer: i ofObject: objOop.
		(self isYoung: oop) ifTrue:
			[^true]].
	^false