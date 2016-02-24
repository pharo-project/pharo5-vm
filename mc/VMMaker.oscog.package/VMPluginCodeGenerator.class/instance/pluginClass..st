public
pluginClass: aPluginClass
	"Set the plugin class and name when generating plugins.
	 And for run-time use, answer the name string."
	| packageId |
	pluginClass := aPluginClass.
	packageId := self shortMonticelloDescriptionForClass: pluginClass.
	(packageId beginsWith: pluginClass name) ifTrue:
		[packageId := packageId allButFirst: pluginClass name size].
	(packageId beginsWith: pluginClass moduleName) ifTrue:
		[packageId := packageId allButFirst: pluginClass moduleName size].
	^self declareModuleName: pluginClass moduleNameAndVersion, packageId