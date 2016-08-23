bytecode generator support
ensureFixupAt: targetIndex
	| fixup |	
	<var: #fixup type: #'BytecodeFixup *'>
	fixup := self fixupAt: targetIndex.
	fixup needsFixup 
		ifTrue: [self mergeCurrentSimStackWith: fixup mergeSimStack ]
		ifFalse: 
			[self assert: fixup mergeSimStack isNil.
			self moveSimStackConstantsToRegisters.
			self setMergeSimStackOf: fixup ].
	^super ensureFixupAt: targetIndex.
