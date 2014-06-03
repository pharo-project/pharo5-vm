primitive support
stackPrimitiveVertexArray: index ofSize: nItems
	"Load a primitive vertex array from the interpreter stack.
	Return a pointer to the vertex data if successful, nil otherwise."
	| oop oopSize |
	<inline: false>
	<returnTypeC:'void*'>
	oop := interpreterProxy stackObjectValue: index.
	oop = nil ifTrue:[^nil].
	(interpreterProxy isWords: oop) ifTrue:[
 		oopSize := interpreterProxy slotSizeOf: oop.
		(oopSize >= nItems * 16 and:[oopSize \\ 16 = 0])
			ifTrue:[^interpreterProxy firstIndexableField: oop]].
	^nil