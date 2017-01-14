compiler support
compilerFlushCache: aCompiledMethod
	^self cCode: 'compilerHooks[2](aCompiledMethod)'