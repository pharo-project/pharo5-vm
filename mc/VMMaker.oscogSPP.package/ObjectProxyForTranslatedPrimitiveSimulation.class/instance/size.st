accessing
size
	unitSize = 1 ifTrue: [^interpreter numBytesOf: oop].
	unitSize = 2 ifTrue: [^interpreter num16BitUnitsOf: oop].
	unitSize = 4 ifTrue: [^interpreter num32BitUnitsOf: oop].
	unitSize = 8 ifTrue: [^interpreter num64BitUnitsOf: oop].
	self halt: 'Can''t handle unitSize ', unitSize printString