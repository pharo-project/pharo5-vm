as yet unclassified
execute
	| instruction |
	[pc ~= EndSimulationPC] whileTrue: 
		[Transcript print: instructionCount; nextPutAll: ' X '; nextPutAll: self currentInstruction; flush.
		 10 milliSeconds asDelay wait.
		 instruction := MIPSInstruction new value: (self fetchInstruction: pc).
		 instruction decodeFor: self.
		 pc := pc + OneInstruction.
		 instructionCount := instructionCount + 1].