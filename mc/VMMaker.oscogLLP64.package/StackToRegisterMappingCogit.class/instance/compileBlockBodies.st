compile abstract instructions
compileBlockBodies
	<inline: false>
	| result compiledBlocksCount blockStart savedNeedsFrame savedNumArgs savedNumTemps
	  initialStackPtr initialOpcodeIndex initialIndexOfIRC |
	<var: #blockStart type: #'BlockStart *'>
	self assert: blockCount > 0.
	"scanBlock: in compileBlockEntry: sets both of these appropriately for each block."
	savedNeedsFrame := needsFrame.
	savedNumArgs := methodOrBlockNumArgs.
	savedNumTemps := methodOrBlockNumTemps.
	inBlock := InVanillaBlock.
	compiledBlocksCount := 0.
	[compiledBlocksCount < blockCount] whileTrue:
		[blockStart := self blockStartAt: compiledBlocksCount.
		  (result := self scanBlock: blockStart) < 0 ifTrue: [^result].
		 initialOpcodeIndex := opcodeIndex.
		 literalsManager saveForBlockCompile.
		 NewspeakVM ifTrue:
			[initialIndexOfIRC := indexOfIRC].
		 [self compileBlockEntry: blockStart.
		  initialStackPtr := simStackPtr.
		  (result := self compileAbstractInstructionsFrom: blockStart startpc + (self pushNilSize: methodObj numInitialNils: blockStart numInitialNils)
						through: blockStart startpc + blockStart span - 1) < 0 ifTrue:
			[^result].
		  "If the final simStackPtr is less than the initial simStackPtr then scanBlock: over-
		   estimated the number of initial nils (because it assumed one or more pushNils to
		   produce an operand were pushNils to initialize temps.  This is very rare, so
		   compensate by checking, adjusting numInitialNils and recompiling the block body.
		   N.B.  No need to reinitialize the literalsManager because it answers existing literals."
		  initialStackPtr = simStackPtr]
			whileFalse:
				[self assert: initialStackPtr > simStackPtr.
				 blockStart numInitialNils: blockStart numInitialNils + simStackPtr - initialStackPtr.
				 blockStart fakeHeader dependent: nil.
				 self reinitializeFixupsFrom: blockStart startpc + blockStart numInitialNils
					through: blockStart startpc + blockStart span - 1.
				 self cCode: 'bzero(abstractOpcodes + initialOpcodeIndex,
									(opcodeIndex - initialOpcodeIndex) * sizeof(AbstractInstruction))'
					inSmalltalk: [initialOpcodeIndex to: opcodeIndex - 1 do:
									[:i| abstractOpcodes at: i put: (CogCompilerClass for: self)]].
				 opcodeIndex := initialOpcodeIndex.
				 literalsManager resetForBlockCompile.
				 NewspeakVM ifTrue:
					[indexOfIRC := initialIndexOfIRC]].
		compiledBlocksCount := compiledBlocksCount + 1].
	needsFrame := savedNeedsFrame.
	methodOrBlockNumArgs := savedNumArgs.
	methodOrBlockNumTemps := savedNumTemps.
	^0