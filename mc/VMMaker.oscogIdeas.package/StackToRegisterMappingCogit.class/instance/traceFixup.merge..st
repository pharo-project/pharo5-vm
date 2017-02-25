simulation only
traceFixup: fixup merge: isMerge
	<cmacro: '(igu,ana) 0'>
	| index |
	(compilationTrace anyMask: 32) ifTrue:
		[index := (fixups object identityIndexOf: fixup) - 1.
		 coInterpreter transcript
			ensureCr;
			print: bytecodePC; nextPutAll: ' -> '; print: index; nextPut: $/; print: index + initialPC;
			nextPut: $:; space.
		 isMerge
			ifTrue: [fixup printStateOn: coInterpreter transcript]
			ifFalse: [coInterpreter transcript nextPutAll: 'non-merge'].
		 coInterpreter transcript cr; flush]