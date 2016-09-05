compile abstract instructions
compileBlockBodies
	<inline: false>
	| result compiledBlocksCount blockStart savedNeedsFrame savedNumArgs |
	<var: #blockStart type: #'BlockStart *'>
	self assert: blockCount > 0.
	"scanBlock: in compileBlockEntry: sets both of these appropriately for each block."
	savedNeedsFrame := needsFrame.
	savedNumArgs := methodOrBlockNumArgs.
	inBlock := InVanillaBlock.
	compiledBlocksCount := 0.
	[compiledBlocksCount < blockCount] whileTrue:
		[blockStart := self blockStartAt: compiledBlocksCount.
		 self scanBlock: blockStart.
		 self compileBlockEntry: blockStart.
		 (result := self compileAbstractInstructionsFrom: blockStart startpc
						through: blockStart startpc + blockStart span - 1) < 0 ifTrue:
			[^result].
		 compiledBlocksCount := compiledBlocksCount + 1].
	needsFrame := savedNeedsFrame.
	methodOrBlockNumArgs := savedNumArgs.
	^0