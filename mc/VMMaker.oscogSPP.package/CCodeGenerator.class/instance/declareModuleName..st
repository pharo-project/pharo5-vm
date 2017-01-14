public
declareModuleName: nameString
	"add the declaration of a module name, version and local/external tag"

	self var: #moduleName declareC:'const char *moduleName =
#ifdef SQUEAK_BUILTIN_PLUGIN
	"', nameString,' (i)"
#else
	"', nameString,' (e)"
#endif
'.
	"and for run-time use, answer the string"
	^nameString, ' (i)'