as yet unclassified
step
	"If the next instruction is a branch, its delay slot will also be executed."	
	| instruction |
	"Transcript print: instructionCount; nextPutAll: ' X '; nextPutAll: self currentInstruction; flush"
	instruction := MIPSInstruction new value: (self fetchInstruction: pc).
	instruction decodeFor: self.
	pc := pc + OneInstruction.
	instructionCount := instructionCount + 1.