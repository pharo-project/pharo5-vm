class table
validClassTableHashes
	"Check the hashes of classes in the table.  The tricky thing here is that classes may be duplicated
	 in the table.  So each entry ,ust be in the table at its hash, even if it is elsewhere in the table."

	self validClassTableRootPages ifFalse:
		[^false].

	0 to: numClassTablePages - 1 do:
		[:i| | page |
		 page := self fetchPointer: i ofObject: hiddenRootsObj.
		 0 to: self classTablePageSize - 1 do:
			[:j| | classOrNil hash |
			classOrNil := self fetchPointer: j ofObject: page.
			classOrNil ~= nilObj ifTrue:
				[(self isForwarded: classOrNil) ifTrue:
					[^0].
				 hash := self rawHashBitsOf: classOrNil.
				 hash = 0 ifTrue:
					[^false].
				 (self noCheckClassAtIndex: hash) ~= classOrNil ifTrue:
					[^false]]]].

	^true