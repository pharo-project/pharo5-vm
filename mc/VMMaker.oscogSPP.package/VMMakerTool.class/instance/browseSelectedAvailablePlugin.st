menus
browseSelectedAvailablePlugin

	| plugin |
	plugin := self availableModules at: self currentAvailableModuleIndex ifAbsent: [^self].
	(Smalltalk classNamed: plugin) browseHierarchy