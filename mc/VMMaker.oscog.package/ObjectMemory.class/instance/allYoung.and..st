become
allYoung: array1 and: array2 
	"Return true if all the oops in both arrays, and the arrays 
	themselves, are in the young object space."
	| fieldOffset |
	(self oop: array1 isLessThan: youngStart)
		ifTrue: [^ false].
	(self oop: array2 isLessThan: youngStart)
		ifTrue: [^ false].
	fieldOffset := self lastPointerOf: array1.
	"same size as array2"
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[(self oop: (self longAt: array1 + fieldOffset) isLessThan: youngStart)
			ifTrue: [^ false].
		((self oop: (self longAt: array2 + fieldOffset) isLessThan: youngStart)
		 and: [self isNonIntegerObject: (self longAt: array2 + fieldOffset)])
			ifTrue: [^ false].
		fieldOffset := fieldOffset - self wordSize].
	^ true