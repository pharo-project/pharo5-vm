initialization
initializeForPlatform
	"Apparently, the VM could crash if these were not correct. 
		Change in future if platform support for the features change"
	self soundQuickStart: self defaultQuickStartForPlatform.
	self stopSoundWhenDone: self defaultStopSoundForPlatform.