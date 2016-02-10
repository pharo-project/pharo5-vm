sources management
addPlatformSources: sources
	^ self addSources: sources prefixed: '$(TOP_PATH)/platforms/unix/plugins/', plugin moduleName , '/'.
