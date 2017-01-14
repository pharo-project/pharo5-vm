primitives
compare: string1 with: string2 collated: order
	"Return 1, 2 or 3, if string1 is <, =, or > string2, with the collating order of characters given by the order array."

	<primitive: 'primitiveCompareString' module: 'MiscPrimitivePlugin'>
	self primitiveFailed
