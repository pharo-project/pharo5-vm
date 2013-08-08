other
fftAt: startIndex
	"Answer the Fast Fourier Transform (FFT) of my samples (only the left channel, if stereo) starting at the given index."

	| availableSamples fftWinSize |
	availableSamples := (leftSamples size - startIndex) + 1.
	fftWinSize := 2 raisedTo: (((availableSamples - 1) log: 2) truncated + 1).
	fftWinSize := fftWinSize min: 4096.
	fftWinSize > availableSamples ifTrue: [fftWinSize := fftWinSize / 2].
	^ self fftWindowSize: fftWinSize startingAt: startIndex
