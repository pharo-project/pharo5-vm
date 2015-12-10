initialization
initialize
	super initialize.
	debug := false.
	"a stupid hack to workaround initialization problems"
	Cogit allSubclassesDo: [ :each | 
		each initializeWithOptions: (VMMaker new instVarNamed: 'optionsDictionary') ]