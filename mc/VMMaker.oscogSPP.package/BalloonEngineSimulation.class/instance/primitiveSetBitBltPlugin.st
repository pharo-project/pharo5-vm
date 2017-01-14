initialize
primitiveSetBitBltPlugin
	"Primitive. Set the BitBlt plugin to use."
	| pluginName |
	pluginName := interpreterProxy stackValue: 0.
	"Must be string to work"
	(interpreterProxy isBytes: pluginName) 
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy stringOf: pluginName) = bbPluginName
		ifTrue: [interpreterProxy pop: 1. "Return receiver"]
		ifFalse: [^interpreterProxy primitiveFail]