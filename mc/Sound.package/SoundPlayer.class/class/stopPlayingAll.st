playing
stopPlayingAll
	"Stop playing all sounds."

	PlayerSemaphore critical: [
		ActiveSounds := ActiveSounds species new].
