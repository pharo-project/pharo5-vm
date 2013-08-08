initialize-release
startUp
	self platformName  = 'Mac OS' "Can be *really* annoying otherwise"
		ifTrue:[[self reopen] ifError: ["ignore"]]