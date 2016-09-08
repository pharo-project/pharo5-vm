class table
isValidClassTag: classIndex
	<api>
	| classOrNil |
	self assert: (classIndex between: 0 and: 1 << self classIndexFieldWidth - 1).
	classOrNil := self classOrNilAtIndex: classIndex.
	^classOrNil ~= nilObj
	 and: [(self rawHashBitsOf: classOrNil) = classIndex]