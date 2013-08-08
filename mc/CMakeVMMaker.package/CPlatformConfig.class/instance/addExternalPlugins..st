plugins
addExternalPlugins: aPluginNames

	aPluginNames do: [:each | self addExternalPlugin: each ]