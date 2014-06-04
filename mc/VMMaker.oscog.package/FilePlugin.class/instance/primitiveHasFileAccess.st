security primitives
primitiveHasFileAccess
	|  hasAccess |
	<export: true>
	"If the security plugin can be loaded, use it to check . 
	If not, assume it's ok"
	sHFAfn ~= 0
		ifTrue: [hasAccess := self cCode: ' ((sqInt (*)(void))sHFAfn)()' inSmalltalk: [true]]
		ifFalse: [hasAccess := true].
	interpreterProxy pop: 1.
	interpreterProxy pushBool: hasAccess