other primitives
primitiveIsBigEnder
	"Answer if running on a big endian machine."
	<export: true>
	self pop: 1 thenPushBool: VMBIGENDIAN