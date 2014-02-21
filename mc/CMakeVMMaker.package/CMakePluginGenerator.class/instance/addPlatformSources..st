accessing
addPlatformSources: sources

	^ self addSources: sources prefixed: '${pluginPlatform}/'
