private
normalizedResultsFromFFT: fft
	"Answer an array whose size is half of the FFT window size containing power in each frequency band, normalized to the average power over the entire FFT. A value of 10.0 in this array thus means that the power at the corresponding frequences is ten times the average power across the entire FFT."

	| r avg |
	r := (1 to: fft realData size // 2) collect:
		[:i | ((fft realData at: i) squared + (fft imagData at: i) squared) sqrt].
	avg := r sum / r size.
	^ r collect: [:v | v / avg].
