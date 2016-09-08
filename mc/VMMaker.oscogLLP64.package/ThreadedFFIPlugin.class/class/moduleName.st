translation
moduleName
	"IMPORTANT: IF YOU CHANGE THE NAME OF THIS PLUGIN YOU MUST CHANGE
		Interpreter>>primitiveCalloutToFFI *and* ThreadedFFIPlugin>>getModuleName
	TO REFLECT THE CHANGE."
	^#('SqueakFFIPrims' 'FFIPlugin') first