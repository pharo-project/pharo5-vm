primitive support
ioLoadExternalFunction: functionName OfLength: functionLength FromModule: moduleName OfLength: moduleLength
	"Load and return the requested function from a module.
	 N.B. The actual code lives in platforms/Cross/vm/sqNamedPrims.h"
	<doNotGenerate>
	| pluginString functionString |
	pluginString := String new: moduleLength.
	1 to: moduleLength do:[:i| pluginString byteAt: i put: (objectMemory byteAt: moduleName+i-1)].
	functionString := String new: functionLength.
	1 to: functionLength do:[:i| functionString byteAt: i put: (objectMemory byteAt: functionName+i-1)].
	^self ioLoadFunction: functionString From: pluginString