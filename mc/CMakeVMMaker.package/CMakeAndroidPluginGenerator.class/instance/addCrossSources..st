sources management
addCrossSources: sources

	^ self addSources: sources prefixed: '$(pluginCross)/'
