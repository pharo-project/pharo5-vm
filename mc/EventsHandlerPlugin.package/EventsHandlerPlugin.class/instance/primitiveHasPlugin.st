primitives
primitiveHasPlugin
	"Just answer true, letting image know we're here"
	<export: true>
	interpreterProxy pop: 1 + (interpreterProxy argumentCountOf: (interpreterProxy primitiveMethod))
	thenPush: interpreterProxy trueObject