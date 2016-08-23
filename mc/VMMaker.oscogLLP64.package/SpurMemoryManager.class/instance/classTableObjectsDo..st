spur bootstrap
classTableObjectsDo: aBlock
	"for the bootstrap..."
	<doNotGenerate>
	0 to: self classTableRootSlots - 1 do:
		[:i| | page |
		page := self fetchPointer: i ofObject: hiddenRootsObj.
		0 to: (self numSlotsOf: page) - 1 do:
			[:j| | classOrNil |
			classOrNil := self fetchPointer: j ofObject: page.
			classOrNil ~= nilObj ifTrue:
				[aBlock value: classOrNil]]]