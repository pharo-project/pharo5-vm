settings
canRecordWhilePlaying
	"Return true if this platform supports simultaneous sound recording and playback."

	^CanRecordWhilePlaying ifNil: [false]
