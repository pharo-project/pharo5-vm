class table
classAtIndex: classIndex put: objOop
	"for become & GC of classes"
	| classTablePage |
	self assert: (classIndex <= self tagMask or: [classIndex >= self arrayClassIndexPun]).
	self assert: (objOop = nilObj
				 or: [((self rawHashBitsOf: objOop) = classIndex						"normal entry"
					  or: [(self classAtIndex: (self rawHashBitsOf: objOop)) = objOop])	"become forces duplicate entry"
					and: [coInterpreter objCouldBeClassObj: objOop]]).
	classTablePage := self fetchPointer: classIndex >> self classTableMajorIndexShift
							ofObject: hiddenRootsObj.
	classTablePage = nilObj ifTrue:
		[self error: 'attempt to add class to empty page'].
	^self
		storePointer: (classIndex bitAnd: self classTableMinorIndexMask)
		ofObject: classTablePage
		withValue: objOop