simulation only
ioLoadFunction: functionString From: pluginString
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter ioLoadFunction: functionString From: pluginString