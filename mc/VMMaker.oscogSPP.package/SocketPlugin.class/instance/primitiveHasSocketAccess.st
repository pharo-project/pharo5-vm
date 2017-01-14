security primitives
primitiveHasSocketAccess
	self primitive: 'primitiveHasSocketAccess'.
	"If the security plugin can be loaded, use it to check . 
	 If not, assume it's ok"
	^(sHSAfn = 0
	  or: [self cCode: ' ((sqInt (*) (void)) sHSAfn)()' inSmalltalk: [true]]) asBooleanObj