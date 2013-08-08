utilities
removeVariable: aName ifAbsent: ifAbsentBlock
	"Remove the given (instance) variable from the code base."
	self checkDeleteVariable: aName.
	variableDeclarations removeKey: aName ifAbsent: [].
	^variables remove: aName ifAbsent: ifAbsentBlock