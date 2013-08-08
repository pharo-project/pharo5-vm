recording controls
resumeRecording
	"Continue recording from the point at which it was last paused."

	self flag: #bob.
	"Note: If canRecordWhilePlaying is true, then recordings may never get started (at least by this method). One possibility, used in a subclass, is to make the #startPlaying unconditional. Another would be to use #startPlaying instead of #resumePlaying in appropriate cases"

	self class canRecordWhilePlaying ifFalse: [self startRecording].
	paused := false.
