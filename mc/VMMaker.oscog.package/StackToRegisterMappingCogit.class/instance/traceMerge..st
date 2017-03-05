simulation only
traceMerge: fixup
	<cmacro: '(ign) 0'>
	| index original |
	(compilationTrace anyMask: 16) ifTrue:
		[index := (fixups object identityIndexOf: fixup) - 1.
		 (fixup isBackwardBranchFixup and: [compilationPass > 1 and: [(original := fixup simStackPtr) < 0]]) ifTrue:
			[fixup simStackPtr: simStackPtr].

		 [coInterpreter transcript
				ensureCr;
				print: index; nextPut: $/; print: index + initialPC;
				nextPut: $:; space.
				fixup printStateOn: coInterpreter transcript.
				coInterpreter transcript cr; flush]
			ensure: [original ifNotNil: [fixup simStackPtr: original]]]