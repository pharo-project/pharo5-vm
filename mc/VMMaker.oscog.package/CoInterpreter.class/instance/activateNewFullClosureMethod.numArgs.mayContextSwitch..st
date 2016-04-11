control primitives
activateNewFullClosureMethod: blockClosure numArgs: numArgs mayContextSwitch: mayContextSwitch
	"Similar to activateNewMethod but for Closure and newMethod."
	| numCopied theMethod methodHeader numTemps |
	<inline: true>
	numCopied := self copiedValueCountOfFullClosure: blockClosure.
	theMethod := objectMemory fetchPointer: FullClosureCompiledBlockIndex ofObject: blockClosure.
	self assert: (objectMemory isOopCompiledMethod: theMethod).
	methodHeader := self rawHeaderOf: theMethod.
	(self isCogMethodReference: methodHeader) ifTrue:
		[^self
			executeFullCogBlock: (self cogMethodOf: theMethod)
			closure: blockClosure
			mayContextSwitch: mayContextSwitch].
	"How do we know when to compile a block method?
	 One simple criterion is to check if the block is running within its inner context,
	 i.e. if the outerContext is married.
	 Even simpler is to remember the previous block entered via the interpreter and
	 compile if this is the same one.  But we can thrash trying to compile an uncoggable
	 method unless we try and remember which ones can't be cogged.  So also record
	 the last block method we failed to compile and avoid recompiling it."
	(self methodWithHeaderShouldBeCogged: methodHeader)
		ifTrue:
			[theMethod = lastCoggableInterpretedBlockMethod
				ifTrue:
					[theMethod ~= lastUncoggableInterpretedBlockMethod ifTrue:
						[cogit cogFullBlockMethod: theMethod numCopied: numCopied.
						 (self methodHasCogMethod: theMethod) ifTrue:
							[^self executeFullCogBlock: (self cogMethodOf: theMethod)
								closure: blockClosure
								mayContextSwitch: mayContextSwitch].
						 cogCompiledCodeCompactionCalledFor ifFalse:
							[lastUncoggableInterpretedBlockMethod := theMethod]]]
				ifFalse:
					[lastCoggableInterpretedBlockMethod := theMethod]]
		ifFalse:
			[self maybeFlagMethodAsInterpreted: theMethod].

	self push: instructionPointer.
	self push: framePointer.
	framePointer := stackPointer.
	self push: theMethod.
	self push: objectMemory nilObject. "FxThisContext field"
	self push: (self encodeFrameFieldHasContext: false isBlock: true numArgs: numArgs).
	self push: 0. "FoxIFSavedIP"
	"Because inst var access is not checked, we must follow the receiver in Spur to ensure it is valid."
	self push: (objectMemory followField: FullClosureReceiverIndex ofObject: blockClosure).

	"Copy the copied values..."
	0 to: numCopied - 1 do:
		[:i|
		self push: (objectMemory
					fetchPointer: i + FullClosureFirstCopiedValueIndex
					ofObject: blockClosure)].

	self assert: (self frameIsBlockActivation: framePointer).
	self assert: (self frameHasContext: framePointer) not.

	methodHeader := objectMemory methodHeaderOf: theMethod.
	numTemps := self temporaryCountOfMethodHeader: methodHeader.

	numArgs + numCopied + 1 to: numTemps do: [ :i | self push: objectMemory nilObject].

	instructionPointer := (self initialPCForHeader: methodHeader method: theMethod) - 1.
	
	self setMethod: theMethod.

	"Now check for stack overflow or an event (interrupt, must scavenge, etc)"
	stackPointer < stackLimit ifTrue:
		[self handleStackOverflowOrEventAllowContextSwitch: mayContextSwitch]