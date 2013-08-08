plugins
addInternalPlugin: aPluginName

	| plugins |
	plugins := self internalPlugins.

	(self externalPlugins includes: aPluginName) ifTrue: [
		self error: 'Cannot add plugin ', aPluginName , ' as internal, because it is already included as external one'
		].
	
	(plugins includes: aPluginName) ifFalse: [ internalPlugins := internalPlugins copyWith: aPluginName ]