bulk processing
setSize: anIntegerPowerOfTwo
	"Initialize variables and tables for performing an FFT on the given number of samples. The number of samples must be an integral power of two (e.g. 1024). Prepare data for use with the fast primitive."

	self nu: (anIntegerPowerOfTwo log: 2) asInteger.
	n = anIntegerPowerOfTwo ifFalse: [self error: 'size must be a power of two'].
	sinTable := sinTable asFloatArray.
	permTable := permTable asWordArray.
	realData := FloatArray new: n.
	imagData := FloatArray new: n.
	self initializeHammingWindow: 0.54.  "0.54 for Hamming, 0.5 for hanning"
