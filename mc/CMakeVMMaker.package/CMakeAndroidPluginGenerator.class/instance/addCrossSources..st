sources management
addCrossSources: sources

	^ self addSources: sources prefixed: '$(TOP_PATH)/platforms/Cross/plugins/', plugin moduleName, '/'.
