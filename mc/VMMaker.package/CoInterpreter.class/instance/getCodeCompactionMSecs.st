internal interpreter access
getCodeCompactionMSecs
	<cmacro: '() integerObjectOf((GIV(statCodeCompactionUsecs) + 500) / 1000)'>
	^objectMemory integerObjectOf: statCodeCompactionUsecs + 500 // 1000