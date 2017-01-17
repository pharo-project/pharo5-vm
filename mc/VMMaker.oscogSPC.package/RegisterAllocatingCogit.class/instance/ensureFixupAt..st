bytecode generator support
ensureFixupAt: targetIndex
	| fixup |	
	<var: #fixup type: #'BytecodeFixup *'>
	fixup := self fixupAt: targetIndex.
	fixup needsFixup 
		ifTrue:
			[fixup mergeSimStack
				ifNil: [self setMergeSimStackOf: fixup]
				ifNotNil: [self mergeCurrentSimStackWith: fixup]]
		ifFalse: 
			[self assert: fixup mergeSimStack isNil.
			self moveVolatileSimStackEntriesToRegisters.
			self setMergeSimStackOf: fixup].
	^super ensureFixupAt: targetIndex