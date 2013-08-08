plugins
externalPlugins
	^ externalPlugins ifNil: [ externalPlugins := self defaultExternalPlugins ]