other
highestSignificantFrequencyAt: startIndex
	"Answer the highest significant frequency in the sample window starting at the given index. The a frequency is considered significant if it's power is at least 1/50th that of the maximum frequency component in the frequency spectrum."

	| fft powerArray threshold indices |
	fft := self fftAt: startIndex.
	powerArray := self normalizedResultsFromFFT: fft.
	threshold := powerArray max / 50.0.
	indices := (1 to: powerArray size) select: [:i | (powerArray at: i) > threshold].
	^ originalSamplingRate / (fft samplesPerCycleForIndex: indices last)
