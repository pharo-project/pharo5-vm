as yet unclassified
initialize
	registers := Array new: 32 withAll: 0.
	pc := 0.
	hi := 0.
	lo := 0.
	inDelaySlot := false.
	instructionCount := 0.