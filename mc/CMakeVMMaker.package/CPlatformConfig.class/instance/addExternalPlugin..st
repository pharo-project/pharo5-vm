plugins
addExternalPlugin: aPluginName

	| plugins |
	plugins := self externalPlugins.
	(self internalPlugins includes: aPluginName) ifTrue: [
		self error: 'Cannot add plugin ', aPluginName , ' as external, because it is already included as internal one'
		].
	(plugins includes: aPluginName) ifFalse: [ externalPlugins := externalPlugins copyWith: aPluginName ]