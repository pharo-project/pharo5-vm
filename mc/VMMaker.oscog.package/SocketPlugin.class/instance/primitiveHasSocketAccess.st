security primitives
primitiveHasSocketAccess
	|  hasAccess |
	<export: true>
	"If the security plugin can be loaded, use it to check . 
	If not, assume it's ok"
	sHSAfn ~= 0
		ifTrue: [hasAccess := self cCode: ' ((int (*) (void)) sHSAfn)()' inSmalltalk:[true]]
		ifFalse: [hasAccess := true].
	interpreterProxy pop: 1.
	interpreterProxy pushBool: hasAccess