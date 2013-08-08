primitives - version testing
primitiveVersionString
	"Answer a string containing the version string for this plugin."

	<export: true>
	interpreterProxy pop: 1; push: (self stringFromCString: self versionString)
