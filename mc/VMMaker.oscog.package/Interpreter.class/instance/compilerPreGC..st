compiler support
compilerPreGC: fullGCFlag
	^self cCode: 'compilerHooks[3](fullGCFlag)'