class table
setHiddenRootsObj: anOop
	hiddenRootsObj := anOop.
	self cCode: [self assert: self validClassTableRootPages]
		inSmalltalk: [numClassTablePages ifNotNil:
						[self assert: self validClassTableRootPages]].
	classTableFirstPage := self fetchPointer: 0 ofObject: hiddenRootsObj.
	self assert: (self numSlotsOf: classTableFirstPage) - 1 = self classTableMinorIndexMask.
	"Hack fix.  A bug in markAndTraceClassOf: caused the class of the first class table page
	 to be changed from its pun.  This can be restored manually, but we do it here too."
	self flag: 'remove at some stage'.
	(self classIndexOf: classTableFirstPage) ~= self arrayClassIndexPun ifTrue:
		[self setClassIndexOf: classTableFirstPage to: self arrayClassIndexPun].
	"Set classTableIndex to the start of the last used page (excepting first page).
	 Set numClassTablePages to the number of used pages."
	numClassTablePages := self classTableRootSlots.
	2 to: numClassTablePages - 1 do:
		[:i|
		(self fetchPointer: i ofObject: hiddenRootsObj) = nilObj ifTrue:
			[numClassTablePages := i.
			 classTableIndex := (numClassTablePages - 1 max: 1) << self classTableMajorIndexShift.
			 ^self]].
	"no unused pages; set it to the start of the second page."
	classTableIndex := 1 << self classTableMajorIndexShift