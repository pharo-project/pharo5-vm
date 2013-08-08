other
copyDownSampledLowPassFiltering: doFiltering
	"Answer a copy of the receiver at half its sampling rate. The result consumes half the memory space, but has only half the frequency range of the original. If doFiltering is true, the original sound buffers are low-pass filtered before down-sampling. This is slower, but prevents aliasing of any high-frequency components of the original signal. (While it may be possible to avoid low-pass filtering when down-sampling from 44.1 kHz to 22.05 kHz, it is probably essential when going to lower sampling rates.)"

	^ self copy downSampleLowPassFiltering: doFiltering
