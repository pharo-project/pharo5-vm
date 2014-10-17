sources management
addPlatformSources: sources

	^ self addSources: sources prefixed: '$(TOP_PATH)/platforms/android/plugins/', plugin moduleName , '/'.
