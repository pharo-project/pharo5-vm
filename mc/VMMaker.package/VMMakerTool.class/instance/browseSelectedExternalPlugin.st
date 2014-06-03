menus
browseSelectedExternalPlugin

	| plugin |
	plugin := self externalModules at: self currentExternalModuleIndex ifAbsent: [^self].
	(Smalltalk classNamed: plugin) browseHierarchy