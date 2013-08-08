compiler support
compilerMapFrom: memStart to: memEnd
	^self cCode: 'compilerHooks[4](memStart, memEnd)'