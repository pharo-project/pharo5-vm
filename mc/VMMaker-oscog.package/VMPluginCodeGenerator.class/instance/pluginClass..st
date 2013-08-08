public
pluginClass: aPluginClass
	"Set the plugin class and name when generating plugins."
	| packageId |
	pluginClass := aPluginClass.
	pluginName := pluginClass moduleName.
	packageId := self shortMonticelloDescriptionForClass: pluginClass.
	(packageId beginsWith: pluginClass name) ifTrue:
		[packageId := packageId allButFirst: pluginClass name size].
	(packageId beginsWith: pluginName) ifTrue:
		[packageId := packageId allButFirst: pluginName size].
	self declareModuleName: pluginClass moduleNameAndVersion, packageId