initialize
initialiseModule
	<export: true>
	self initSurfacePluginFunctionPointers.
	"By default, disable logging"
	ffiLogEnabled := false.
	"Get the instSize of ExternalFunction to know whether it contains a cache of the stackSize,
	 and what the offset of ExternalLibraryFunction's functionName and moduleName slots are."
	externalFunctionInstSize := interpreterProxy instanceSizeOf: interpreterProxy classExternalFunction.
	^1