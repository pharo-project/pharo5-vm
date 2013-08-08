trimming
normalizeFactorFor: percentOfMaxVolume min: min max: max dcOffset: dcOffset
	"Return a normalization factor for the range of sample values and DC offset. A normalization factor is a fixed-point number that will be divided by 1000 after multiplication with each sample value."

	| peak factor |
	peak := (max - dcOffset) max: (min - dcOffset) negated.
	peak = 0 ifTrue: [^ 1000].
	factor := (32767.0 * percentOfMaxVolume) / (100.0 * peak).
	^ (factor * 1000.0) asInteger
