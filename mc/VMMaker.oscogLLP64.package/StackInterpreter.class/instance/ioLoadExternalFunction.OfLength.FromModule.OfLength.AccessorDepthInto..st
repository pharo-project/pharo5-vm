primitive support
ioLoadExternalFunction: functionName OfLength: functionLength FromModule: moduleName OfLength: moduleLength AccessorDepthInto: accessorDepthPtr
	"Load and return the requested function from a module.  Assign the accessor depth through accessorDepthPtr.
	 N.B. The actual code lives in platforms/Cross/vm/sqNamedPrims.h"
	<doNotGenerate>
	| pluginString functionString |
	pluginString := String new: moduleLength.
	1 to: moduleLength do:[:i| pluginString byteAt: i put: (objectMemory byteAt: moduleName+i-1)].
	functionString := String new: functionLength.
	1 to: functionLength do:[:i| functionString byteAt: i put: (objectMemory byteAt: functionName+i-1)].
	"Pharo images as of 2016 use the FFI plugin (for getenv:?).  We can't simulate such function loads.  So ignore"
	pluginString = 'SqueakFFIPrims' ifTrue:
		["self halt."
		 true ifTrue:
			[self transcript cr; show: 'ignoring function load from SqueakFFIPrims'.
			 ^0]].
	^self ioLoadFunction: functionString From: pluginString AccessorDepthInto: accessorDepthPtr