primitives
hashBytes: aByteArray startingWith: speciesHash
	"Answer the hash of a byte-indexed collection,
	using speciesHash as the initial value.
	See SmallInteger>>hashMultiply.

	The primitive should be renamed at a
	suitable point in the future"

	<primitive: 'primitiveStringHash' module: 'MiscPrimitivePlugin'>
	self primitiveFailed
