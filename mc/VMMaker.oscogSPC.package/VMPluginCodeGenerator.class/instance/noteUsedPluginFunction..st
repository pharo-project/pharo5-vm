public
noteUsedPluginFunction: aSelector
	"Remember aSelector and answer whether the call should be made through
	 interpreterProxy. If not, it will be made either directly (in an internal plugin)
	 or through a local copy of the function pointer (in an external plugin)."
	pluginFunctionsUsed add: aSelector.
	"These two are static to sqVirtualMachine.c and so
	 they must be called through the interpreterProxy."
	^#(majorVersion minorVersion) includes: aSelector