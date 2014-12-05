trampolines
ceClassAtIndex: classIndex
	<api>
	| result |
	result := self classAtIndex: classIndex.
	self assert: (coInterpreter addressCouldBeClassObj: result).
	^result