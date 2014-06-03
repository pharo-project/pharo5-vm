class table
classOrNilAtIndex: classIndex
	<api>
	| classTablePage |
	self assert: (classIndex <= self tagMask or: [classIndex >= self arrayClassIndexPun]).
	classTablePage := self fetchPointer: classIndex >> self classTableMajorIndexShift
							ofObject: hiddenRootsObj.
	classTablePage = nilObj ifTrue:
		[^nilObj].
	^self
		fetchPointer: (classIndex bitAnd: self classTableMinorIndexMask)
		ofObject: classTablePage