class table
isForwardedClassIndex: maybeClassIndex
	"A lenient tester of forwarded class indices for inline cache management in the Cogit."
	<api>
	| classTablePage entry |
	maybeClassIndex asUnsignedInteger >= self classTableRootSlots ifTrue:
		[^false].
	classTablePage := self fetchPointer: maybeClassIndex >> self classTableMajorIndexShift
							ofObject: hiddenRootsObj.
	classTablePage = nilObj ifTrue:
		[^false].
	entry := self
				fetchPointer: (maybeClassIndex bitAnd: self classTableMinorIndexMask)
				ofObject: classTablePage.
	^self isForwarded: entry