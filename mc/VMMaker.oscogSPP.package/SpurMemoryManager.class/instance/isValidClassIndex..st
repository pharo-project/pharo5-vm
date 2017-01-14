class table
isValidClassIndex: classIndex
	| classTablePage |
	classIndex <= 0 ifTrue:
		[^false].
	(classIndex <= self tagMask or: [classIndex >= self arrayClassIndexPun]) ifFalse:
		[^false].
	classIndex >= (1 << self classIndexFieldWidth) ifTrue:
		[^false].
	classTablePage := self fetchPointer: classIndex >> self classTableMajorIndexShift
							ofObject: hiddenRootsObj.
	classTablePage = nilObj ifTrue:
		[^false].
	(self addressCouldBeObj: classTablePage) ifFalse:
		[false].
	^coInterpreter addressCouldBeClassObj:
		(self
			fetchPointer: (classIndex bitAnd: self classTableMinorIndexMask)
			ofObject: classTablePage)