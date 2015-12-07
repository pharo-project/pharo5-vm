as yet unclassified
executeDelaySlot
	| instruction |
	self assert: inDelaySlot not.
	inDelaySlot := true.
	instructionCount := instructionCount + 1.
	"Transcript print: instructionCount; nextPutAll: ' D '; nextPutAll: self currentInstruction; flush."
	instruction := MIPSInstruction new value: (self fetchInstruction: pc).
	instruction decodeFor: self.
	inDelaySlot := false.