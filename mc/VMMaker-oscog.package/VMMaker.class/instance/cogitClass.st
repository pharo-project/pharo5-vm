generate sources
cogitClass
	^(cogitClassName
		ifNil: [self interpreterClass cogitClass]
		ifNotNil: [Smalltalk classNamed: cogitClassName]) translationClass