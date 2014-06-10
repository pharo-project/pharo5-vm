compiler support
setCompilerInitialized: newFlag
	| oldFlag |
	oldFlag := compilerInitialized.
	compilerInitialized := newFlag.
	^oldFlag