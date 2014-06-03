compiler support
compilerPreGCHook: fullGCFlag
	<inline: true>
	compilerInitialized ifTrue: [self compilerPreGC: fullGCFlag]