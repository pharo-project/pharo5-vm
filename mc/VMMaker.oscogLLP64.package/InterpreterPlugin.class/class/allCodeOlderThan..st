translation
allCodeOlderThan: modificationTime
	^((self pluginClassesUpToRoot) allSatisfy:
			[:aPluginClass| aPluginClass timeStamp < modificationTime])
	  and: [self translatedPrimitives allSatisfy:
			[:pair| | c m stamp |
			c := Smalltalk classNamed: pair first.
			m := c compiledMethodAt: pair last ifAbsent: [c class >> pair last].
			stamp := (m timeStamp subStrings: {Character space}) last: 2.
			stamp := TimeStamp date: (Date fromString: stamp first) time: (Time fromString: stamp last).
			stamp asSeconds < modificationTime]]