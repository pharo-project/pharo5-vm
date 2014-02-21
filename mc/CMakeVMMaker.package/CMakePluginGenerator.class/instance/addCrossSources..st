accessing
addCrossSources: sources

	^ self addSources: sources prefixed: '${pluginCross}/'
