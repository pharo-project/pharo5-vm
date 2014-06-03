C code generator
emitExportsOn: aStream
	"Store all the exported primitives in the form used by the internal named prim system."
	aStream cr; cr; nextPutAll:'#ifdef SQUEAK_BUILTIN_PLUGIN'.
	self emitExportsNamed: pluginName pluginName: pluginName on: aStream.
	aStream cr; nextPutAll: '#else /* ifdef SQ_BUILTIN_PLUGIN */'; cr; cr.
	self emitAccessorDepthsOn: aStream.
	aStream cr; nextPutAll: '#endif /* ifdef SQ_BUILTIN_PLUGIN */'; cr