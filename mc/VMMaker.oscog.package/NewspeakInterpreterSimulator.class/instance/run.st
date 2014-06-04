testing
run
	"Just run"
	quitBlock := [([transcript dependents anyOne outermostMorphThat: [:m| m isSystemWindow]]
					on: Error
					do: [:ex| nil])
						ifNotNil: [:window| (UIManager default confirm: 'close?') ifTrue: [window delete]].
				  ^self].
	self loadInitialContext.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue:
		[self assertValidExecutionPointers.
		 atEachStepBlock value. "N.B. may be nil"
		 self dispatchOn: currentBytecode in: BytecodeTable.
		 self incrementByteCount].
	localIP := localIP - 1.
	"undo the pre-increment of IP before returning"
	self externalizeIPandSP