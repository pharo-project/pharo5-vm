compiler support
compilerFlushCacheHook: aCompiledMethod
	<inline: true>
	compilerInitialized ifTrue: [self compilerFlushCache: aCompiledMethod]