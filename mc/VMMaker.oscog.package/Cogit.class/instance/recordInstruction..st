simulation only
recordInstruction: thing
	<doNotGenerate>
	lastNInstructions addLast: thing.
	[lastNInstructions size > 160"80"] whileTrue:
		[lastNInstructions removeFirst.
		 lastNInstructions size * 2 > lastNInstructions capacity ifTrue:
			[lastNInstructions makeRoomAtLast]].
	^thing