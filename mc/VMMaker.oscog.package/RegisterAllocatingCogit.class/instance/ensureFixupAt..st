bytecode generator support
ensureFixupAt: targetPC
	"Make sure there's a flagged fixup at the target pc in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction.
	 Override to enerate stack merging code if required."
	| fixup |	
	<var: #fixup type: #'BytecodeFixup *'>
	self assert: targetPC > bytecodePC.
	fixup := self fixupAt: targetPC.
	fixup needsFixup 
		ifTrue:
			[fixup mergeSimStack
				ifNil: [self setMergeSimStackOf: fixup]
				ifNotNil: [self mergeCurrentSimStackWith: fixup forwards: true]]
		ifFalse: 
			[self assert: (fixup mergeSimStack isNil or: [compilationPass = 2]).
			 self moveVolatileSimStackEntriesToRegisters.
			 fixup mergeSimStack
				ifNil: [self setMergeSimStackOf: fixup]
				ifNotNil: [self assert: (self simStack: simStack isIdenticalTo: fixup mergeSimStack)]].
	^super ensureFixupAt: targetPC