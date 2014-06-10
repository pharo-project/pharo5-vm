generate machine code
alignUptoRoutineBoundary: anAddress 
	^anAddress + 7 bitClear: 7