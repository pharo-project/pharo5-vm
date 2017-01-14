debug support
nameOfClass: classOop
	(self sizeBitsOf: classOop) = (Metaclass instSize +1*self wordSize) ifTrue:
		[^ (self nameOfClass:
				(self fetchPointer: 5 "thisClass" ofObject: classOop)) , ' class'].
	^ self stringOf: (self fetchPointer: 6 "name" ofObject: classOop)