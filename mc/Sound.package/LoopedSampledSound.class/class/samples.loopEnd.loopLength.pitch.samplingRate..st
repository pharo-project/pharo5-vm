instance creation
samples: aSoundBuffer loopEnd: loopEndIndex loopLength: loopSampleCount pitch: perceivedPitchInHz samplingRate: samplingRateInHz
	"See the comment in the instance method of this name."

	^ self basicNew
		samples: aSoundBuffer
		loopEnd: loopEndIndex
		loopLength: loopSampleCount
		pitch: perceivedPitchInHz
		samplingRate: samplingRateInHz
