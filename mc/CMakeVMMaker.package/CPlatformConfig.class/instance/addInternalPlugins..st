plugins
addInternalPlugins: aPluginNames

	aPluginNames do: [:each | self addInternalPlugin: each ]