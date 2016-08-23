initialize
getModuleName
	"Note: This is hardcoded so it can be run from Squeak.
	The module name is used for validating a module *after*
	it is loaded to check if it does really contain the module
	we're thinking it contains. This is important!"
	<returnTypeC:'const char*'>
	<export: true>
	^self cCode: [moduleName]
		inSmalltalk:
			[self class codeGeneratorClass new pluginClass: self class]