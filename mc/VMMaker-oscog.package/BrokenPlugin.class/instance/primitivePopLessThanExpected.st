primitives
primitivePopLessThanExpected
	"Pops less than expected; call this with two arguments."
	<export: true>
	interpreterProxy pop: interpreterProxy methodArgumentCount - 1.
