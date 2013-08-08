primitives
primitiveModuleName
	"Answer a string containing the module name string for this plugin."

	<export: true>
	interpreterProxy pop: 1 thenPush: (self stringFromCString: self getModuleName)
