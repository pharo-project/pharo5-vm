testing
isLoaded
	^ alienHandle notNil and:[ SmalltalkImage current listLoadedModules anySatisfy:[:each| each beginsWith: self libraryName]].