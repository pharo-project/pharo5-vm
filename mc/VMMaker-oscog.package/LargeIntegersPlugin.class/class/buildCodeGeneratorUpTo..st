translation
buildCodeGeneratorUpTo: someClass 
	"A hook to control generation of the plugin. Don't know how to set the 
	debug mode otherwise if using the VMMaker gui. Possibly there is a better way."
	| cg |
	cg := super buildCodeGeneratorUpTo: someClass.
	"example: cg generateDebugCode: true."
	^ cg