compile abstract instructions
scanBlock: blockStart
	super scanBlock: blockStart.
	needsFrame ifTrue:
		[| tempCount |
		 tempCount := coInterpreter tempCountForBlockStartingAt: blockStart startpc + 1 in: methodObj.
		 blockStart numInitialNils ~= tempCount ifTrue:
			[blockStart numInitialNils: tempCount]]