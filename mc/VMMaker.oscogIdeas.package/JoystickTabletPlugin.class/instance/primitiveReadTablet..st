primitives
primitiveReadTablet: cursorIndex
	"Get the current state of the cursor of the pen tablet specified by my argument. Fail if there is no tablet. If successful, the result is an array of integers; see the Smalltalk call on this primitive for its interpretation."

	| resultSize result resultPtr|
	<var: #resultPtr type: 'int * '>
	self primitive: 'primitiveReadTablet'
		parameters: #(SmallInteger).
	resultSize := self tabletResultSize.
	result := interpreterProxy instantiateClass: interpreterProxy classBitmap indexableSize: resultSize.
	resultPtr := result asIntPtr.
	interpreterProxy success: (self cCode: 'tabletRead(cursorIndex, resultPtr)').
	^result