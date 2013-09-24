object enumeration
classTableObjectsDo: aBlock
	0 to: (self numSlotsOf: classTableRootObj) - 1 do:
		[:i| | page |
		page := self fetchPointer: i ofObject: classTableRootObj.
		0 to: (self numSlotsOf: page) - 1 do:
			[:j| | classOrNil |
			classOrNil := self fetchPointer: j ofObject: page.
			classOrNil ~= nilObj ifTrue:
				[aBlock value: classOrNil]]]