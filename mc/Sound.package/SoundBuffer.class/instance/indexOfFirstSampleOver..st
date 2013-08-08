utilities
indexOfFirstSampleOver: threshold
	"Return the index of the first sample whose absolute value is over the given threshold value. Return an index one greater than my size if no sample is over the threshold."

	1 to: self size do: [:i |
		(self at: i) abs > threshold ifTrue: [^ i]].
	^ self size + 1