player process
startPlayerProcessBufferSize: bufferSize rate: samplesPerSecond stereo: stereoFlag
	"Start the sound player process. Terminate the old process, if any."
	"SoundPlayer startPlayerProcessBufferSize: 1000 rate: 11025 stereo: false"
	^self startPlayerProcessBufferSize: bufferSize 
			rate: samplesPerSecond 
			stereo: stereoFlag 
			sound: nil