class table
classAtIndex: classIndex
	<api>
	<inline: true>
	| classTablePage |
	self assert: (classIndex >= 0 and: [classIndex <= self tagMask or: [classIndex >= self arrayClassIndexPun and: [classIndex <= self classIndexMask]]]).
	classTablePage := self fetchPointer: classIndex >> self classTableMajorIndexShift
							ofObject: hiddenRootsObj.
	classTablePage = nilObj ifTrue:
		[^nil].
	^self
		fetchPointer: (classIndex bitAnd: self classTableMinorIndexMask)
		ofObject: classTablePage