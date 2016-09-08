class table
noCheckClassAtIndex: classIndex
	| classTablePage |
	classTablePage := self fetchPointer: classIndex >> self classTableMajorIndexShift
							ofObject: hiddenRootsObj.
	classTablePage = nilObj ifTrue:
		[^nil].
	^self
		fetchPointer: (classIndex bitAnd: self classTableMinorIndexMask)
		ofObject: classTablePage