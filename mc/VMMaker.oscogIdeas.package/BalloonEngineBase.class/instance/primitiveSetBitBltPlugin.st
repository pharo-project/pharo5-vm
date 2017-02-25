primitives-access
primitiveSetBitBltPlugin
	"Primitive. Set the BitBlt plugin to use."
	| pluginName length ptr needReload |
	<export: true>
	<var: #ptr type:'char *'>
	pluginName := interpreterProxy stackValue: 0.
	"Must be string to work"
	(interpreterProxy isBytes: pluginName) 
		ifFalse:[^interpreterProxy primitiveFail].
	length := interpreterProxy byteSizeOf: pluginName.
	length >= 256 
		ifTrue:[^interpreterProxy primitiveFail].
	ptr := interpreterProxy firstIndexableField: pluginName.
	needReload := false.
	0 to: length-1 do:[:i|
		"Compare and store the plugin to be used"
		(bbPluginName at: i) = (ptr at: i) ifFalse:[
			bbPluginName at: i put: (ptr at: i).
			needReload := true]].
	(bbPluginName at: length) = 0 ifFalse:[
		bbPluginName at: length put: 0.
		needReload := true].
	needReload ifTrue:[
		self initialiseModule 
			ifFalse:[^interpreterProxy primitiveFail]].
	interpreterProxy pop: 1. "Return receiver"