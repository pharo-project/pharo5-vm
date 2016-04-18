debug printing
printMergeSimStack
	<doNotGenerate>
	self notAFixup ifFalse:
		[cogit printSimStack: mergeSimStack toDepth: simStackPtr spillBase: -1]