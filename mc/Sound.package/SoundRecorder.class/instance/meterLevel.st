accessing
meterLevel
	"Return the meter level, an integer in the range [0..100] where zero is silence and 100 represents the maximum signal level possible without clipping."

	^ (100 * meterLevel) // 32768
