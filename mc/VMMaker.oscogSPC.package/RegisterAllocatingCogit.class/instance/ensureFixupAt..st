bytecode generator support
ensureFixupAt: targetPC
	"Make sure there's a flagged fixup at the target pc in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction.
	 Override to enerate stack merging code if required."
	| fixup |	
	<var: #fixup type: #'BytecodeFixup *'>
	fixup := self fixupAt:  targetPC.
	fixup needsFixup 
		ifTrue:
			[fixup mergeSimStack
				ifNil: [self setMergeSimStackOf: fixup]
				ifNotNil: [self mergeCurrentSimStackWith: fixup]]
		ifFalse: 
			[self assert: fixup mergeSimStack isNil.
			 self moveVolatileSimStackEntriesToRegisters.
			 self setMergeSimStackOf: fixup].
	^super ensureFixupAt: targetPC