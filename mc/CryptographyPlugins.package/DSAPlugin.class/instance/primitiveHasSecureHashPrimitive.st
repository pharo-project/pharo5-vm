primitives-SHA
primitiveHasSecureHashPrimitive
	"Answer true if the secure hash primitive is implemented."

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushBool: true.
