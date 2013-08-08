testing
run
	"Just run"
	quitBlock := [| topWindow |
				  
				   (displayView notNil
				   and: [topWindow := displayView outermostMorphThat:
									[:m| m isSystemWindow and: [World submorphs includes: m]].
						topWindow notNil
				   and: [UIManager default confirm: 'close?']]) ifTrue:
					[topWindow delete].
				  ^self].
	self initStackPages.
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