primitive support
stackPrimitiveVertex: index
	"Load a primitive vertex from the interpreter stack.
	Return a pointer to the vertex data if successful, nil otherwise."
	| oop |
	<inline: false>
	<returnTypeC:'void*'>
	oop := interpreterProxy stackObjectValue: index.
	oop = nil ifTrue:[^nil].
	((interpreterProxy isWords: oop) and:[(interpreterProxy slotSizeOf: oop) = 16])
		ifTrue:[^interpreterProxy firstIndexableField: oop].
	^nil