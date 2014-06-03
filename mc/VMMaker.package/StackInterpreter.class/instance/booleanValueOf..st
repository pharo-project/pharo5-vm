utilities
booleanValueOf: obj
"convert true and false (Smalltalk) to true or false(C)"
	obj = objectMemory trueObject ifTrue: [ ^ true ].
	obj = objectMemory falseObject ifTrue: [ ^ false ].
	self success: false.
	^ nil