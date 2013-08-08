initialization
computeSampleCountForRelease
	"Calculate the number of samples before the end of the note after which looping back will be be disabled. The units of this value, sampleCountForRelease, are samples at the original sampling rate. When playing a specific note, this value is converted to releaseCount, which is number of samples to be computed at the current pitch and sampling rate."
	"Details: For short loops, set the sampleCountForRelease to the loop length plus the number of samples between loopEnd and lastSample. Otherwise, set it to 1/10th of a second worth of samples plus the number of samples between loopEnd and lastSample. In this case, the trailing samples will be played only if the last loop-back occurs within 1/10th of a second of the total note duration, and the note may be shortened by up to 1/10th second. For long loops, this is the best we can do."

	(scaledLoopLength > 0 and: [lastSample > loopEnd])
		ifTrue: [
			sampleCountForRelease := (lastSample - loopEnd) +
				(self loopLength min: (originalSamplingRate / 10.0)) asInteger]
		ifFalse: [sampleCountForRelease := 0].

	releaseCount := sampleCountForRelease.
