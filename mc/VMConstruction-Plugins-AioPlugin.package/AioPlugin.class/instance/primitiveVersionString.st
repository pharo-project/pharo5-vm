primitives
primitiveVersionString
	"Answer a string containing the version string for this plugin."

	<export: true>
	interpreterProxy pop: 1 thenPush: (self stringFromCString: self versionString)
