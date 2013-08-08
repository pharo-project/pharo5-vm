playing
waitUntilDonePlaying: aSound
	"Wait until the given sound is no longer playing."

	[PlayerSemaphore critical: [ActiveSounds includes: aSound]]
		whileTrue: [(Delay forMilliseconds: 100) wait].
