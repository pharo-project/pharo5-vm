playing
canStartPlayer
	"Some platforms do no support simultaneous record and play. If this is one of those platforms, return false if there is a running SoundRecorder."

	^SoundRecorder canRecordWhilePlaying 
		or: [SoundRecorder anyActive not]