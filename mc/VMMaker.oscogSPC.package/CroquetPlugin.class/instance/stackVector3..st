transforms
stackVector3: index
	"Load a Vector3 from the interpreter stack.
	Return a pointer to the float data if successful, nil otherwise."
	| oop |
	<inline: false>
	<returnTypeC:'void*'>
	oop := interpreterProxy stackObjectValue: index.
	oop = nil ifTrue:[^nil].
	((interpreterProxy isWords: oop) and:[(interpreterProxy slotSizeOf: oop) = 3])
		ifTrue:[^interpreterProxy firstIndexableField: oop].
	^nil