as yet unclassified
addPlatformSources: sources

	^ self addSources: sources prefixed: '${pluginPlatform}/'
