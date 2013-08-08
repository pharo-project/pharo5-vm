plugin lists
canSupportPlugin: pluginClassName 
	"see if this plugin needs any external files and if so, check to see if 
	they seem to exist."
	[self validatePlugin: pluginClassName in: allPlugins , internalPlugins , externalPlugins]
		on: VMMakerException
		do: [^ false].
	^ true