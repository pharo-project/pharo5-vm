menus
browseSelectedInternalPlugin

	| plugin |
	plugin := self internalModules at: self currentInternalModuleIndex ifAbsent: [^self].
	(Smalltalk classNamed: plugin) browseHierarchy