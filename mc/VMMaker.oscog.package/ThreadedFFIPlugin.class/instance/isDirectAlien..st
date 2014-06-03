primitive support
isDirectAlien: oop
	self assert: (self isAlien: oop).
	^(self sizeField: oop) > 0