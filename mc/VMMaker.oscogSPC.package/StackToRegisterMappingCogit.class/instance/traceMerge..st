simulation only
traceMerge: fixup
	<cmacro: '(ign) 0'>
	| index |
	(compilationTrace anyMask: 16) ifTrue:
		[index := (fixups object identityIndexOf: fixup) - 1.
		 coInterpreter transcript
			ensureCr;
			print: index; nextPut: $/; print: index + initialPC;
			nextPut: $:; space.
			fixup printStateOn: coInterpreter transcript.
			coInterpreter transcript cr; flush]