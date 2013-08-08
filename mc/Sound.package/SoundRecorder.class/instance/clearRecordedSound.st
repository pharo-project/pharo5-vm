recording controls
clearRecordedSound
	"Clear the sound recorded thus far. Go into pause mode if currently recording."

	paused := true.
	recordedSound := SequentialSound new.
	self allocateBuffer.
