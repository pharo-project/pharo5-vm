class table
classAtIndex: classIndex
	| classTablePage |
	self assert: (classIndex <= self tagMask or: [classIndex >= self arrayClassIndexPun]).
	classTablePage := self fetchPointer: classIndex >> self classTableMajorIndexShift
							ofObject: classTableRootObj.
	classTablePage = nilObj ifTrue:
		[^nil].
	^self
		fetchPointer: (classIndex bitAnd: self classTableMinorIndexMask)
		ofObject: classTablePage