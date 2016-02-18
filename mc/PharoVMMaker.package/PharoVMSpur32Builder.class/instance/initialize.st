initialization
initialize
	super initialize.
	self generateForRelease.
	"a stupid hack to workaround initialization problems"
	Cogit allSubclassesDo: [ :each | 
		each initializeWithOptions: (VMMaker new instVarNamed: 'optionsDictionary') ]