processor api
initializeStackFor: aCogit
	self flag: #OABI.
	aCogit setStackAlignment: 8 expectedSPOffset: 0 expectedFPOffset: 0.
	