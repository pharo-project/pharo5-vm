recording controls
playback
	"Playback the sound that has been recorded."

	self pause.
	soundPlaying := self recordedSound.
	soundPlaying play.
