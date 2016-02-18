public
pluginClass: aPluginClass
	"Set the plugin class and name when generating plugins.
	 And for run-time use, answer the name string."
	| packageId |
	pluginClass := aPluginClass.
	pluginName := pluginClass moduleName.
	packageId := self shortMonticelloDescriptionForClass: pluginClass.
	(packageId beginsWith: pluginClass name) ifTrue:
		[packageId := packageId allButFirst: pluginClass name size].
	(packageId beginsWith: pluginName) ifTrue:
		[packageId := packageId allButFirst: pluginName size].
	^self declareModuleName: pluginClass moduleNameAndVersion, packageId