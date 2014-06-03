generate sources
interpreterClass

	^(Smalltalk classNamed: interpreterClassName) ifNotNil:
		[:interpreterClass| interpreterClass translationClass]