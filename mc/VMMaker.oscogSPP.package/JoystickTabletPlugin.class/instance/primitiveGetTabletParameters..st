primitives
primitiveGetTabletParameters: cursorIndex
	"Get information on the pen tablet attached to this machine. Fail if there is no tablet. If successful, the result is an array of integers; see the Smalltalk call on this primitive for its interpretation."

	| resultSize result resultPtr |
	<var: #resultPtr type: 'int * '>
	self primitive: 'primitiveGetTabletParameters'
		parameters: #(SmallInteger).
	resultSize := self tabletResultSize.
	result := interpreterProxy instantiateClass: interpreterProxy classBitmap indexableSize: resultSize.
	resultPtr := result asIntPtr.
	interpreterProxy success: (self cCode: 'tabletGetParameters(cursorIndex, resultPtr)').
	^result