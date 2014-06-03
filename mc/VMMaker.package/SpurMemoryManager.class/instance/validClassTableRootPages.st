class table
validClassTableRootPages
	"Answer if hiddenRootsObj is of the right size with the
	 expected contents, and if numClassTablePages is correct."

	(self numSlotsOf: hiddenRootsObj) = (self classTableRootSlots + self hiddenRootSlots) ifFalse:
		[^false].

	"is it in range?"
	(numClassTablePages > 1 and: [numClassTablePages <= self classTableRootSlots]) ifFalse:
		[^false].
	"are all pages the right size?"
	0 to: numClassTablePages - 1 do:
		[:i| | obj |
		 obj := self fetchPointer: i ofObject: hiddenRootsObj.
		 ((self addressCouldBeObj: obj)
		  and: [(self numSlotsOf: obj) = self classTablePageSize]) ifFalse:
			[^false]].
	"are all entries beyond numClassTablePages nil?"
	numClassTablePages to: self classTableRootSlots - 1 do:
		[:i|
		(self fetchPointer: i ofObject: hiddenRootsObj) ~= nilObj ifTrue:
			[^false]].
	^true