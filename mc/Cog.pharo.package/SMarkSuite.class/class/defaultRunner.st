defaults
defaultRunner
	^ self onCog: [SMarkCogRunner]
	       else:  [SMarkRunner]