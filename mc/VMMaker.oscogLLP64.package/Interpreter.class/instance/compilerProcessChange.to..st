compiler support
compilerProcessChange: oldProc to: newProc
	^self cCode: 'compilerHooks[6](oldProc, newProc)'