system startup
shutDown: quitting
	self allSubInstancesDo:
		[:processor|
		SavedState at: processor put: processor registerState]