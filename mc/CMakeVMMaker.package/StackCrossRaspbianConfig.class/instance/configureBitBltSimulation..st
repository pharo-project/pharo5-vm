as yet unclassified
configureBitBltSimulation: maker
	"extra rules for BitBltSimulation"

	maker includeDirectories: '${pluginCross}'.

	maker addCrossSources: #(
		'BitBltGeneric.c'
		'BitBltDispatch.c'
	).
	