translation
translateDoInlining: inlineFlag locally: localFlag debug: debugFlag 
	^ self
		translate: self moduleName , '.c'
		doInlining: inlineFlag
		locally: localFlag
		debug: debugFlag