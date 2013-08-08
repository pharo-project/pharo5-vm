recording controls
pause
	"Go into pause mode. The record level continues to be updated, but no sound is recorded."

	paused := true.
	((currentBuffer ~~ nil) and: [nextIndex > 1])
		ifTrue: [self emitPartialBuffer.
				self allocateBuffer].

	soundPlaying ifNotNil: [
		soundPlaying pause.
		soundPlaying := nil].
	"Note: there can be problems if canRecordWhilePlaying is true. Recorders which only pause will inhibit other recorders from recording. I chose to make #stopPlaying unconditional in a subclass. The same might be appropriate here at the expense of making recorders resumable"

	self class canRecordWhilePlaying ifFalse: [self stopRecording].
