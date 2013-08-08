plugins
internalPlugins
	^ internalPlugins ifNil: [ internalPlugins := self defaultInternalPlugins ]