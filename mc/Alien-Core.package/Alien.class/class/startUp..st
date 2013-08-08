system startup
startUp: resuming
	resuming ifTrue:
		["The io lock is off in the new session, so we shut down the process if it's running."
		ProcessIoEvents := false]