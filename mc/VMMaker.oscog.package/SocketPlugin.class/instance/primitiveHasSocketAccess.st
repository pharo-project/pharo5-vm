security primitives
primitiveHasSocketAccess
	| hasAccess |
	<export: true>
	"If the security plugin can be loaded, use it to check . 
	 If not, assume it's ok"
	hasAccess :=	sHSAfn = 0
					or: [self cCode: ' ((sqInt (*) (void)) sHSAfn)()' inSmalltalk:[true]].
	interpreterProxy pop: 1.
	interpreterProxy pushBool: hasAccess