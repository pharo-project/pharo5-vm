C code generation
emitCCodeOn: aStream level: level generator: aCodeGen
	| printMod expansions duplicates |
	printMod := false.
	(expression isVariable
	 and: [expression name = 'currentBytecode']) ifTrue:
		[printMod := true.
		 aStream nextPutAll: 'bytecodeDispatchDebugHook();'; cr; crtab: level.
		 aCodeGen outputAsmLabel: 'bytecodeDispatch' on: aStream.
		 aStream crtab: level].
	aStream nextPutAll: 'switch ('.
	expression emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'; cr.
	expansions := aCodeGen suppressAsmLabelsWhile:
						[cases collect:
							[:case|
							self filterCommentsFrom:
								(String streamContents:
									[:s|
									case emitCCodeOn: s level: 0 generator: aCodeGen])]].
	duplicates := Set new.
	1 to: cases size do:
		[:i|
		(duplicates includes: i) ifFalse:
			[(duplicates addAll: ((i to: cases size) select: [:j| (expansions at: i) = (expansions at: j)])) do:
				[:k|
				(firsts at: k) to: (lasts at: k) do:
					[:caseIndex|
					aStream tab: level; nextPutAll: 'case '; print: caseIndex; nextPut: $:.
					(caseIndex > 255 and: [printMod]) ifTrue:
						[aStream nextPutAll: ' /*'; print: (caseIndex bitAnd: 255); nextPutAll: '*/'].
					aStream cr]].
			(cases at: i) emitCCodeOn: aStream level: level + 1 generator: aCodeGen.
			aStream tab: level + 1; nextPutAll: 'break;'; cr]].
	aStream tab: level; nextPut: $}