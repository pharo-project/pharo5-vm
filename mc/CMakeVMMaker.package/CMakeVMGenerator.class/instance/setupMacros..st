as yet unclassified
setupMacros: gen
	self config cMakeMacros
		ifNotNil: [ :macros | gen puts: macros ]