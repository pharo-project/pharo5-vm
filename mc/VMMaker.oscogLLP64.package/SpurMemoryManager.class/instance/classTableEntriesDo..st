class table
classTableEntriesDo: binaryBlock
	"Evaluate binaryBlock with all non-nil entries in the classTable and their index."
	<inline: true>
	0 to: numClassTablePages - 1 do:
		[:i| | page |
		 page := self fetchPointer: i ofObject: hiddenRootsObj.
		 0 to: self classTablePageSize - 1 do:
			[:j| | classOrNil |
			classOrNil := self fetchPointer: j ofObject: page.
			classOrNil ~= nilObj ifTrue:
				[binaryBlock
					value: classOrNil
					value: i << self classTableMajorIndexShift + j]]]