compiler support
compilerMapHookFrom: memStart to: memEnd
	<inline: true>
	compilerInitialized ifTrue: [self compilerMapFrom: memStart to: memEnd]