private
fftWindowSize: windowSize startingAt: startIndex
	"Answer a Fast Fourier Transform (FFT) of the given number of samples starting at the given index (the left channel only, if stereo). The window size will be rounded up to the nearest power of two greater than the requested size. There must be enough samples past the given starting index to accomodate this window size."

	| nu n fft |
	nu := ((windowSize - 1) log: 2) truncated + 1.
	n := 2 raisedTo: nu.
	fft := FFT new nu: nu.
	fft realData: ((startIndex to: startIndex + n - 1) collect: [:i | leftSamples at: i]).
	^ fft transformForward: true.
