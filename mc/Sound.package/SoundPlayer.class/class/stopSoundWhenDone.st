settings
stopSoundWhenDone
	"If true, the sound player is shut down after playing finished"
	^(SoundsStopWhenDone ifNil: [self defaultStopSoundForPlatform]) 